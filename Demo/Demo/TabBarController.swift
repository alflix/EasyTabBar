//
//  TabBarController.swift
//  CircleQ
//
//  Created by John on 2018/9/21.
//  Copyright © 2018 Ganguo. All rights reserved.
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
        addChilds()
        delegate = self
    }
}

private extension TabBarController {
    func setupUI() {
        tabBar.isTranslucent = false
        tabBar.appearance = TabBarAppearance(unselectedTintColor: .lightGray, selectedTintColor: .red,
                                             titleFont: .systemFont(ofSize: 11))
    }

    func addChilds() {
        add(child: UIViewController(),
            imageName: "icon_tab_nearby",
            selectImageName: "icon_tab_nearby_hl",
            title: titles[0],
            navigationClass: UINavigationController.self)
        add(child: UIViewController(),
            imageName: "icon_tab_activity",
            selectImageName: "icon_tab_activity_hl",
            title: titles[1],
            navigationClass: UINavigationController.self)
        add(child: UIViewController(),
            imageName: "icon_tab_publish",
            selectImageName: "icon_tab_publish_hl",
            title: titles[2],
            isBulge: true,
            navigationClass: UINavigationController.self)
        add(child: UIViewController(),
            imageName: "icon_tab_message",
            selectImageName: "icon_tab_message_hl",
            title: titles[3],
            navigationClass: UINavigationController.self)
        add(child: UIViewController(),
            imageName: "icon_tab_mine",
            selectImageName: "icon_tab_mine_hl",
            title: titles[4],
            navigationClass: UINavigationController.self)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
