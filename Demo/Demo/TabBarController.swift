//
//  TabBarController.swift
//  CircleQ
//
//  Created by John on 2018/9/21.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    var lastIndex: Int = 0

    var titles: [String] {
        return ["nearby", "activity", "send", "message", "mine"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addChilds2()
    }
}

private extension TabBarController {
    func setupUI() {
        tabBar.isTranslucent = false
        tabBar.appearance = TabBarAppearance(unselectedTintColor: .lightGray, selectedTintColor: .red,
                                             titleFont: .systemFont(ofSize: 11))
    }

    func addChilds() {
        add(child: NearbyViewController(),
            imageName: "icon_tab_nearby",
            selectImageName: "icon_tab_nearby_hl",
            title: titles[0],
            navigationClass: UINavigationController.self)
        add(child: ActivityViewController(),
            imageName: "icon_tab_activity",
            selectImageName: "icon_tab_activity_hl",
            title: titles[1],
            navigationClass: UINavigationController.self)
        add(child: SendViewController(),
            imageName: "icon_tab_publish",
            selectImageName: "icon_tab_publish_hl",
            title: titles[2],
            navigationClass: UINavigationController.self)
        add(child: MessageViewController(),
            imageName: "icon_tab_message",
            selectImageName: "icon_tab_message_hl",
            title: titles[3],
            navigationClass: UINavigationController.self)
        add(child: MineViewController(),
            imageName: "icon_tab_mine",
            selectImageName: "icon_tab_mine_hl",
            title: titles[4],
            navigationClass: UINavigationController.self)
    }

    func addChilds2() {
        add(child: NearbyViewController(),
            imageName: "icon_tab_home",
            selectImageName: "icon_tab_home_hl",
            title: "首页",
            navigationClass: UINavigationController.self)
        add(child: ActivityViewController(),
            imageName: "icon_tab_category",
            selectImageName: "icon_tab_category_hl",
            title: "分类",
            navigationClass: UINavigationController.self)
        add(child: SendViewController(),
            imageName: "icon_tab_fashion",
            selectImageName: "icon_tab_fashion_hl",
            title: "潮流日本",
            navigationClass: UINavigationController.self)
        add(child: MessageViewController(),
            imageName: "icon_tab_shopBag",
            selectImageName: "icon_tab_shopBag_hl",
            title: "购物袋",
            navigationClass: UINavigationController.self)
        add(child: MineViewController(),
            imageName: "icon_tab_me",
            selectImageName: "icon_tab_me_hl",
            title: "我",
            navigationClass: UINavigationController.self)
    }
}
