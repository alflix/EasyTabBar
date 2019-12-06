//
//  UITabBarItem+.swift
//  EasyTabBar
//
//  Created by John on 2019/3/19.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

extension UITabBarItem {
    public convenience init(title: String?) {
        self.init()
        self.title = title
    }

    fileprivate struct AssociatedKey {
        static var bulgeOffsetY: String = "com.UITabBarItem.bulgeOffsetY"
    }

    /// 中间有凸起的 TabBar，其往上移动的偏移量
    open var bulgeOffsetY: CGFloat {
        get {
            if let value = associatedObject(forKey: &AssociatedKey.bulgeOffsetY) as? CGFloat { return value }
            return 0
        }
        set {            
            associate(assignObject: newValue, forKey: &AssociatedKey.bulgeOffsetY)
        }
    }
}
