//
//  UITabBar+.swift
//  EasyTabBar
//
//  Created by John on 2019/3/19.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

public struct TabBarAppearance {
    /// 未选中状态的控件颜色(图标，文字)
    public var unselectedTintColor: UIColor?
    /// 选中状态的控件颜色(图标，文字)
    public var selectedTintColor: UIColor?
    /// 文字字体
    public var titleFont: UIFont?
    /// 是否显示顶部横线
    public var isShowShadowLine = true

    public init(unselectedTintColor: UIColor? = nil,
                selectedTintColor: UIColor? = nil,
                titleFont: UIFont? = nil,
                isShowShadowLine: Bool = true) {
        self.unselectedTintColor = unselectedTintColor
        self.selectedTintColor = selectedTintColor
        self.titleFont = titleFont
        self.isShowShadowLine = isShowShadowLine
    }
}

public extension UITabBar {
    fileprivate struct AssociatedKey {
        static var appearance: String = "com.tabBar.appearance"
    }

    var appearance: TabBarAppearance? {
        get {
            if let value = associatedObject(forKey: &AssociatedKey.appearance) as? TabBarAppearance { return value }
            return nil
        }
        set {
            guard let appearance = newValue else { return }
            setupAppearance(appearance)
            associate(retainObject: newValue, forKey: &AssociatedKey.appearance)
        }
    }

    func setupAppearance(_ appearance: TabBarAppearance) {
        if !appearance.isShowShadowLine {
            if #available(iOS 13, *) {
                // MARK: need copy
                let appearance = standardAppearance.copy()
                appearance.shadowColor = .clear
                standardAppearance = appearance
            } else {
                backgroundImage = UIImage()
                shadowImage = UIImage()
            }
        }
        if let unselectedTintColor = appearance.unselectedTintColor {
            if #available(iOS 13, *) {
                let appearance = standardAppearance.copy()
                appearance.stackedLayoutAppearance.normal.iconColor = unselectedTintColor
                appearance.stackedLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = unselectedTintColor

                appearance.inlineLayoutAppearance.normal.iconColor = unselectedTintColor
                appearance.inlineLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = unselectedTintColor

                appearance.compactInlineLayoutAppearance.normal.iconColor = unselectedTintColor
                appearance.compactInlineLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = unselectedTintColor

                standardAppearance = appearance
            } else if #available(iOS 10.0, *) {
                unselectedItemTintColor = unselectedTintColor
            }
        }

        if let selectedTintColor = appearance.selectedTintColor {
            if #available(iOS 13, *) {
                let appearance = standardAppearance.copy()
                appearance.stackedLayoutAppearance.selected.iconColor = selectedTintColor
                appearance.stackedLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = selectedTintColor

                appearance.inlineLayoutAppearance.selected.iconColor = selectedTintColor
                appearance.inlineLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = selectedTintColor

                appearance.compactInlineLayoutAppearance.selected.iconColor = selectedTintColor
                appearance.compactInlineLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = selectedTintColor

                standardAppearance = appearance
            } else {
                tintColor = selectedTintColor
            }
        }

        if let titleFont = appearance.titleFont {
            if #available(iOS 13, *) {
                let appearance = standardAppearance.copy()
                appearance.stackedLayoutAppearance.normal.titleTextAttributes[.font] = titleFont
                appearance.stackedLayoutAppearance.selected.titleTextAttributes[.font] = titleFont

                appearance.inlineLayoutAppearance.normal.titleTextAttributes[.font] = titleFont
                appearance.inlineLayoutAppearance.selected.titleTextAttributes[.font] = titleFont

                appearance.compactInlineLayoutAppearance.normal.titleTextAttributes[.font] = titleFont
                appearance.compactInlineLayoutAppearance.selected.titleTextAttributes[.font] = titleFont

                standardAppearance = appearance
            } else if #available(iOS 10.0, *) {
                UITabBarItem.appearance().setTitleTextAttributes([.font: titleFont], for: .normal)
            }
        }
    }
}
