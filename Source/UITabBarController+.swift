//
//  UITabBarController+.swift
//  EasyTabBar
//
//  Created by John on 2019/3/19.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

public extension UITabBarController {
    override func viewDidLoad() {
        let customTabBar = BulgeTabBar()
        setValue(customTabBar, forKeyPath: "tabBar")
        super.viewDidLoad()
    }

    /// 添加子控制器
    ///
    /// - Parameters:
    ///   - controller: 子控制器
    ///   - imageName: 图标, 选中/未选中图标根据 tintColor/unselectedTintColor 而定
    ///   - title: 文字
    func add(child controller: UIViewController, imageName: String, title: String? = nil) {
        add(child: controller, imageName: imageName, selectImageName: nil,
            title: title, navigationClass: UINavigationController.self)
    }

    /// 添加子控制器
    ///
    /// - Parameters:
    ///   - controller: 子控制器
    ///   - imageName: 图标
    ///   - selectImageName: 选中的图标
    ///     - 不为空时，imageName 对应未选中的图标，selectImageName 对应选中的图标
    ///     - 为空时，选中/未选中图标根据 imageName 以及 tintColor/unselectedTintColor 而定
    ///   - title: 文字
    ///   - isBulge: 是否凸起
    ///   - name: 可传入继承自 UINavigationController 的 class
    ///   - tabBarItemUpdate: tabBarItemUpdate
    ///   - bulgeClosure: 凸起按钮的点击回调
    func add<T: UINavigationController>(child controller: UIViewController,
                                        imageName: String,
                                        selectImageName: String? = nil,
                                        title: String? = nil,
                                        bulgeOffsetY: CGFloat = 0,
                                        navigationClass name: T.Type,
                                        bulgeClosure: (() -> Void)? = nil) {
        guard let image = UIImage(named: imageName) else {
            fatalError("cant find image by imageName!")
        }
        guard let title = title else {
            fatalError("title can't be nil!")
        }
        guard let bulgeTabBar: BulgeTabBar = tabBar as? BulgeTabBar else {
            fatalError("BulgeTabBar")
        }

        let tabBarItem = UITabBarItem(title: title)
        tabBarItem.bulgeOffsetY = bulgeOffsetY
        let index = children.count
        // 原先的 controller.tabBarItem 设一个空的占位，然后添加一个 UIButton 进去，selectedImage 作为 UIButton 的 hightlighted 状态显示
        tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        if let selectImageName = selectImageName, let selectedImage = UIImage(named: selectImageName) {
            tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        }
        bulgeTabBar.addBulgeIndexs(index: index, tabBarItem: tabBarItem) {
            self.selectedIndex = index
            bulgeClosure?()
        }

        let fakeTabBarItem = UITabBarItem()
        controller.tabBarItem = fakeTabBarItem
        
        let navigationController = T(rootViewController: controller)
        addChild(navigationController)
    }

    /// 刷新标题（例如语言更新）
    func reloadTitles(titles: [String]) {
        guard let viewControllers = viewControllers else { return }
        for (index, viewController) in viewControllers.enumerated() {
            viewController.tabBarItem.title = titles[index]
        }
    }
}
