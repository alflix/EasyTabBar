//
//  BulgeTabBar.swift
//  EasyTabBar
//
//  Created by John on 2019/3/25.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

public class BulgeTabBar: UITabBar {
    private var bulgeIndexs: [Int] = []
    private var indexToButton: [Int: LayoutButton] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        var tabBarButtonIndex = -1
        for tabbarButton in subviews where NSStringFromClass(type(of: tabbarButton)) == "UITabBarButton" {
            tabBarButtonIndex += 1
            if bulgeIndexs.contains(tabBarButtonIndex) {
                if let button = indexToButton[tabBarButtonIndex] {
                    button.sizeToFit()
                    tabbarButton.addSubview(button)
                    button.fillSuperview()
                }
            }
        }
        layoutSubviews()
    }

    // 处理超出区域点击无效的问题
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            for tabbarButton in subviews where NSStringFromClass(type(of: tabbarButton)) == "UITabBarButton" {
                for button in tabbarButton.subviews where button is LayoutButton {
                    let tempPoint = button.convert(point, from: self)
                    if button.bounds.contains(tempPoint) {
                        return button
                    }
                }
            }
        }
        return super.hitTest(point, with: event)
    }

    /// - Parameters:
    ///   - index: 凸起 item 的位置
    ///   - tabBarItem: 支持 title, image，selectedImage 的设置
    ///   - closure: 点击回调
    func addBulgeIndexs(index: Int, tabBarItem: UITabBarItem, _ closure: (() -> Void)?) {
        /// 之所以用 Button，而不是调整原先的 UITabBarButton，是因为 highlighted 状态的显示
        let button = LayoutButton()
        button.imageDirection = .top
        button.setTitleColor(appearance?.unselectedTintColor, for: .normal)
        button.setTitleColor(appearance?.selectedTintColor, for: .selected)
        button.titleLabel?.font = appearance?.titleFont
        button.setTitle(tabBarItem.title, for: .normal)

        button.setImage(tabBarItem.image, for: .normal)
        button.setImage(tabBarItem.selectedImage, for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = false

        button.bulgeOffsetY = tabBarItem.bulgeOffsetY
        button.imageTitleSpace = 4
        button.isSelected = index == 0
        _ = button.on(.touchUpInside) { (_) in
            self.indexToButton.forEach { $0.value.isSelected = false }
            button.isSelected = true
            closure?()
        }
        indexToButton[index] = button
        bulgeIndexs.append(index)
    }
}
