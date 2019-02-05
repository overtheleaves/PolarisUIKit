//
//  Palette.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 01/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//
import Foundation
import UIKit

/// make LinkState hashable
public func == (lhs: LinkState, rhs: LinkState) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public class Palette {
    // color chip
    public static var backgroundColor: UIColor?
    public static var themeColor: UIColor?
    public static var shadowColor: UIColor?
    
    public static var defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    public static var h1Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize * 2)), // 2em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var h2Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize * 1.5)), // 1.5em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var h3Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize * 1.17)), // 1.17em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var h4Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize)), // 1em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var h5Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize * 0.83)), // 0.83em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var h6Attribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize * 0.67)), // 0.67em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    public static var pAttribute: StyleAttribute =
        StyleAttribute(textAttribute: nil,
                       fontAttribute: FontAttribute(font: Palette.defaultFont.withSize(UIFont.systemFontSize)), // 1em
                        backgroundAttribute: nil,
                        boxAttribute: nil,
                        imageAttribute: nil)
    
    private static var customAttribute: [String:[LinkState:StyleAttribute]] = [:]
    
    public static func addAttribute(_ name: String, attribute: StyleAttribute, linkState: LinkState? = .normal) {
      
        if customAttribute[name] == nil {
            customAttribute[name] = [:]
        }
        
        customAttribute[name]![linkState!] = attribute
    }
    
    public static func getAttribute(type: DefaultStyleAttributeType) -> StyleAttribute {
        switch type {
        case .h1:
            return h1Attribute
        case .h2:
            return h2Attribute
        case .h3:
            return h3Attribute
        case .h4:
            return h4Attribute
        case .h5:
            return h5Attribute
        case .h6:
            return h6Attribute
        case .p:
            return pAttribute
        }
    }
    
    public static func getAttribute(name: String, linkState: LinkState? = .normal) -> StyleAttribute? {
        switch name {
        case DefaultStyleAttributeType.h1.rawValue:
            return h1Attribute
        case DefaultStyleAttributeType.h2.rawValue:
            return h2Attribute
        case DefaultStyleAttributeType.h3.rawValue:
            return h3Attribute
        case DefaultStyleAttributeType.h4.rawValue:
            return h4Attribute
        case DefaultStyleAttributeType.h5.rawValue:
            return h5Attribute
        case DefaultStyleAttributeType.h6.rawValue:
            return h6Attribute
        case DefaultStyleAttributeType.p.rawValue:
            return pAttribute
        default :
            if let dict = customAttribute[name] {
                return dict[linkState!]
            } else {
                return nil
            }
        }
    }
    
    public static func decorateLayer(_ layer: CALayer, view: UIView, attribute: StyleAttribute) {
        
        /// background attribute
        /// - background color
        layer.backgroundColor = attribute.backgroundAttribute.color.cgColor
        
        /// - border 
        layer.borderColor = attribute.boxAttribute.borderColor.cgColor
        layer.borderWidth = attribute.boxAttribute.borderWidth
        
        if attribute.boxAttribute.borderRadiusWithHeightRatio > 0.0 {
            layer.cornerRadius = view.layer.frame.height
                * attribute.boxAttribute.borderRadiusWithHeightRatio
        } else {
            layer.cornerRadius = attribute.boxAttribute.borderRadius
        }
        
        /// - shadow
        layer.shadowColor = attribute.boxAttribute.shadowColor.cgColor
        layer.shadowOffset = attribute.boxAttribute.shadowOffset
        layer.shadowRadius = attribute.boxAttribute.shadowRadius
        layer.shadowOpacity = attribute.boxAttribute.shadowOpacity
    }
}

public enum DefaultStyleAttributeType: String {
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"
    case p = "p"
}

public enum LinkState: Int {
    case normal
    case hover
    case pressed
    case disabled
}

public class StyleAttribute {
    public var textAttribute: TextAttribute = TextAttribute()
    public var fontAttribute: FontAttribute = FontAttribute()
    public var backgroundAttribute: BackgroundAttribute = BackgroundAttribute()
    public var boxAttribute: BoxAttribute = BoxAttribute()
    public var imageAttribute: ImageAttribute?
    
    public init() { }
    public init(textAttribute: TextAttribute?, fontAttribute: FontAttribute?,
                backgroundAttribute: BackgroundAttribute?, boxAttribute: BoxAttribute?, imageAttribute: ImageAttribute?) {
        self.textAttribute = textAttribute ?? self.textAttribute
        self.fontAttribute = fontAttribute ?? self.fontAttribute
        self.backgroundAttribute = backgroundAttribute ?? self.backgroundAttribute
        self.boxAttribute = boxAttribute ?? self.boxAttribute
        self.imageAttribute = imageAttribute
    }
}

public class TextAttribute {
    public var color: UIColor = UIColor.black
    public var letterSpacing: CGFloat = CGFloat(1.0)
    
    public init() { }
    public init(color: UIColor, letterSpacing: CGFloat) {
        self.color = color
        self.letterSpacing = letterSpacing
    }
}

public class FontAttribute {
    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    public init() { }
    public init (font: UIFont) {
        self.font = font
    }
}

public class BackgroundAttribute {
    public var color: UIColor = UIColor.white
    
    public init() { }
    public init(color: UIColor) {
        self.color = color
    }
}

public class BoxAttribute {
    
    // margin
    public var margin: CGFloat = CGFloat(0.0) {
        didSet {
            self.marginTop = margin
            self.marginBottom = margin
            self.marginLeft = margin
            self.marginRight = margin
        }
    }
    public var marginTop: CGFloat = CGFloat(0.0)
    public var marginBottom: CGFloat = CGFloat(0.0)
    public var marginLeft: CGFloat = CGFloat(0.0)
    public var marginRight: CGFloat = CGFloat(0.0)
    
    // padding
    public var padding: CGFloat = CGFloat(0.0) {
        didSet {
            self.paddingTop = padding
            self.paddingBottom = padding
            self.paddingLeft = padding
            self.paddingRight = padding
        }
    }
    public var paddingTop: CGFloat = CGFloat(0.0)
    public var paddingBottom: CGFloat = CGFloat(0.0)
    public var paddingLeft: CGFloat = CGFloat(0.0)
    public var paddingRight: CGFloat = CGFloat(0.0)
    
    // border
    public var borderRadius: CGFloat = CGFloat(0.0)
    public var borderRadiusWithHeightRatio: CGFloat = CGFloat(0.0)
    public var borderWidth: CGFloat = CGFloat(0.0)
    public var borderColor: UIColor = UIColor.clear
    
    // shadow
    public var shadowColor: UIColor = UIColor.black
    public var shadowOffset: CGSize = CGSize(width: 0, height: -3)
    public var shadowRadius: CGFloat = 3
    public var shadowOpacity: Float = 0.0
}


public class ImageAttribute {
    public var image: UIImage?
    
    public init() { }
    public init(image: UIImage) {
        self.image = image
    }
}
