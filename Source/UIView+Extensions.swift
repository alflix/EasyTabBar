//
//  UIView+.swift
//  EasyTabBar
//
//  Created by John on 2019/3/25.
//  Copyright © 2019 John. All rights reserved.
//
import UIKit

extension UIView {
    func fillSuperview() {
        guard let superview = self.superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

	    let constraints: [NSLayoutConstraint] = [
    	    leftAnchor.constraint(equalTo: superview.leftAnchor),
    	    rightAnchor.constraint(equalTo: superview.rightAnchor),
    	    topAnchor.constraint(equalTo: superview.topAnchor),
    	    bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    	    ]
	    NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func centerInSuperview() -> (centerX: NSLayoutConstraint, centerY: NSLayoutConstraint) {
        guard let superview = self.superview else {
            fatalError()
        }
        translatesAutoresizingMaskIntoConstraints = false
        let centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        let constraints: [NSLayoutConstraint] = [ centerX, centerY ]
        NSLayoutConstraint.activate(constraints)
        return (centerX, centerY)
    }

    func constraint(equalTo size: CGSize) {
        guard superview != nil else { return }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func addConstraints(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                        bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                        centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil,
                        topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0,
                        rightConstant: CGFloat = 0, centerYConstant: CGFloat = 0, centerXConstant: CGFloat = 0,
                        widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {

        if self.superview == nil {
            return []
        }
        translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: topConstant)
            constraint.identifier = "top"
            constraints.append(constraint)
        }

        if let left = left {
            let constraint = leftAnchor.constraint(equalTo: left, constant: leftConstant)
            constraint.identifier = "left"
            constraints.append(constraint)
        }

        if let bottom = bottom {
            let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
            constraint.identifier = "bottom"
            constraints.append(constraint)
        }

        if let right = right {
            let constraint = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
            constraint.identifier = "right"
            constraints.append(constraint)
        }

        if let centerY = centerY {
            let constraint = centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant)
            constraint.identifier = "centerY"
            constraints.append(constraint)
        }

        if let centerX = centerX {
            let constraint = centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant)
            constraint.identifier = "centerX"
            constraints.append(constraint)
        }

        if widthConstant > 0 {
            let constraint = widthAnchor.constraint(equalToConstant: widthConstant)
            constraint.identifier = "width"
            constraints.append(constraint)
        }

        if heightConstant > 0 {
            let constraint = heightAnchor.constraint(equalToConstant: heightConstant)
            constraint.identifier = "height"
            constraints.append(constraint)
        }

        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
