//
//  UIView+StyleAttributeExtension.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 02/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

fileprivate struct AssociatedKeys {
    static var type: UInt8 = 0
    static var attribute: UInt8 = 0
}

extension UIView: StyleAttributeCompatible {
}

public extension StyleAttributeExtension where Base: UIView {
    public var type: String? {
        get {
            return objc_getAssociatedObject(base, &AssociatedKeys.type) as? String
        }
        
        set(newValue) {
            objc_setAssociatedObject(base, &AssociatedKeys.type, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var attribute: StyleAttribute? {
        get {
            return objc_getAssociatedObject(base, &AssociatedKeys.attribute) as? StyleAttribute
        }
        
        set(newValue) {
            objc_setAssociatedObject(base, &AssociatedKeys.attribute, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension UIView {
    
    public func getAttributedPaddingRect(original bounds: CGRect) -> CGRect {
        
        if let attribute = self.styleAttr.attribute {
            
            let rect = CGRect(origin: bounds.origin,
                              size: CGSize(width: bounds.width
                                + attribute.boxAttribute.paddingLeft
                                + attribute.boxAttribute.paddingRight,
                                           height: bounds.height
                                            + attribute.boxAttribute.paddingTop
                                            + attribute.boxAttribute.paddingBottom
            ))
            
            // make rect with inset
            rect.inset(by: UIEdgeInsets(top: attribute.boxAttribute.paddingTop,
                                        left: attribute.boxAttribute.paddingLeft,
                                        bottom: attribute.boxAttribute.paddingBottom,
                                        right: attribute.boxAttribute.paddingRight))
            return rect
            
        } else {
            return bounds
        }
    }
}
