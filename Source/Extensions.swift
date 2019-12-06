//
//  Extensions.swift
//  Alamofire
//
//  Created by John on 2019/11/2.
//

import Foundation
import UIKit

extension UIImage {
    func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

extension NSObject {
    /// Sets an associated value for a given object using a weak reference to the associated object.
    /// **Note**: the `key` underlying type must be String.
    func associate(assignObject object: Any?, forKey key: UnsafeRawPointer) {
        let strKey: String = convertUnsafePointerToSwiftType(key)
        willChangeValue(forKey: strKey)
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_ASSIGN)
        didChangeValue(forKey: strKey)
    }

    /// Sets an associated value for a given object using a strong reference to the associated object.
    /// **Note**: the `key` underlying type must be String.
    func associate(retainObject object: Any?, forKey key: UnsafeRawPointer) {
        let strKey: String = convertUnsafePointerToSwiftType(key)
        willChangeValue(forKey: strKey)
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        didChangeValue(forKey: strKey)
    }

    /// Sets an associated value for a given object using a copied reference to the associated object.
    /// **Note**: the `key` underlying type must be String.
    func associate(copyObject object: Any?, forKey key: UnsafeRawPointer) {
        let strKey: String = convertUnsafePointerToSwiftType(key)
        willChangeValue(forKey: strKey)
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        didChangeValue(forKey: strKey)
    }

    /// Returns the value associated with a given object for a given key.
    /// **Note**: the `key` underlying type must be String.
    func associatedObject(forKey key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, key)
    }

    func convertUnsafePointerToSwiftType<T>(_ value: UnsafeRawPointer) -> T {
        return value.assumingMemoryBound(to: T.self).pointee
    }
}

private var HandlerKey: UInt8 = 0

extension UIControl {
    /// Adds a handler that will be invoked for the specified control events
    func on(_ controlEvents: UIControl.Event, invokeHandler handler: @escaping (UIControl) -> Void) -> AnyObject {
        let closureHandler = ClosureHandler(handler: handler, control: self)
        addTarget(closureHandler, action: ClosureHandlerSelector, for: controlEvents)
        var handlers = self.handlers ?? Set<ClosureHandler<UIControl>>()
        handlers.insert(closureHandler)
        self.handlers = handlers
        return closureHandler
    }

    /// Removes a handler from the control
    func removeHandler(_ handler: AnyObject) {
        guard let handler = handler as? ClosureHandler<UIControl> else { return }
        removeTarget(handler, action: ClosureHandlerSelector, for: .allEvents)
        if var handlers = self.handlers {
            handlers.remove(handler)
            self.handlers = handlers
        }
    }
}

private extension UIControl {
    var handlers: Set<ClosureHandler<UIControl>>? {
        get { return objc_getAssociatedObject(self, &HandlerKey) as? Set<ClosureHandler<UIControl>> }
        set { objc_setAssociatedObject(self, &HandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

internal let ClosureHandlerSelector = Selector(("handle"))

internal class ClosureHandler<T: AnyObject>: NSObject {
    internal var handler: ((T) -> Void)?
    internal weak var control: T?

    internal init(handler: @escaping (T) -> Void, control: T? = nil) {
        self.handler = handler
        self.control = control
    }

    @objc func handle() {
        if let control = self.control {
            handler?(control)
        }
    }
}
