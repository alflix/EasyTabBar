//
//  BulgeTabBar.swift
//  EasyTabBar
//
//  Created by John on 2019/3/25.
//  Copyright © 2019 Ganguo. All rights reserved.
//

import UIKit

class BulgeTabBar: UITabBar {
    /// 往上移动的偏移量
    var offsetY: CGFloat = 0
    private var bulgeIndexs: [Int] = []
    private var indexToButton: [Int: UIButton] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        var tabBarButtonIndex = -1
        for tabbarButton in subviews where NSStringFromClass(type(of: tabbarButton)) == "UITabBarButton" {
            tabBarButtonIndex += 1
            if bulgeIndexs.contains(tabBarButtonIndex) {
                if let button = indexToButton[tabBarButtonIndex] {
                    button.frame = tabbarButton.frame
                    button.frame.origin.y -= offsetY
                    addSubview(button)
                }
            }
        }
        layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 13, *) {
            // fix https://github.com/Tencent/QMUI_iOS/issues/740
            let tabBarButtons = self.subviews.filter { NSStringFromClass(type(of: $0)) == "UITabBarButton" }
            for tabbarButton in tabBarButtons {
                if let label = tabbarButton.subviews.filter({ NSStringFromClass(type(of: $0)) == "UITabBarButtonLabel" }).first {
                    label.sizeToFit()
                }
            }
        }
    }

    // 处理超出区域点击无效的问题
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            for subview in subviews where NSStringFromClass(type(of: subview)) == "UIButton" {
                let tempPoint = subview.convert(point, from: self)
                if subview.bounds.contains(tempPoint) {
                    return subview
                }
            }
        }
        return super.hitTest(point, with: event)
    }

    /// - Parameters:
    ///   - index: 凸起 item 的位置
    ///   - tabBarItem: 支持 image，selectedImage（实际是用于 highlighted）的设置
    ///   - closure: 点击回调
    func addBulgeIndexs(index: Int, tabBarItem: UITabBarItem, _ closure: (() -> Void)?) {
        /// 之所以用 Button，而不是调整原先的 UITabBarButton，是因为 highlighted 状态的显示
        let button = UIButton()
        button.setImage(tabBarItem.image, for: .normal)
        button.setImage(tabBarItem.selectedImage, for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = false
        _ = button.on(.touchUpInside) { (_) in
            closure?()
        }
        indexToButton[index] = button
        bulgeIndexs.append(index)
    }
}
