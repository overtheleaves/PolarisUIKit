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
    
    // color scheme
    public static let lightGreen: UIColor = UIColor(red: 105/255, green: 224/255, blue: 161/255, alpha: 1.0)
    public static let green: UIColor = UIColor(red: 67/255, green: 203/255, blue: 131/255, alpha: 1.0)
    public static let darkGreen: UIColor = UIColor(red: 45/255, green: 168/255, blue: 103/255, alpha: 1.0)
    
    public static let lightBlue: UIColor = UIColor(red: 113/255, green: 207/255, blue: 243/255, alpha: 1.0)
    public static let blue: UIColor = UIColor(red: 80/255, green: 186/255, blue: 226/255, alpha: 1.0)
    public static let darkBlue: UIColor = UIColor(red: 58/255, green: 158/255, blue: 195/255, alpha: 1.0)
    
    public static let lightRed: UIColor = UIColor(red: 251/255, green: 136/255, blue: 103/255, alpha: 1.0)
    public static let red: UIColor = UIColor(red: 245/255, green: 120/255, blue: 70/255, alpha: 1.0)
    public static let darkRed: UIColor = UIColor(red: 219/255, green: 99/255, blue: 52/255, alpha: 1.0)

    public static let lightOrange: UIColor = UIColor(red: 253/255, green: 204/255, blue: 126/255, alpha: 1.0)
    public static let orange: UIColor = UIColor(red: 249/255, green: 185/255, blue: 74/255, alpha: 1.0)
    public static let darkOrange: UIColor = UIColor(red: 231/255, green: 161/255, blue: 51/255, alpha: 1.0)

    public static let lightViolet: UIColor = UIColor(red: 142/255, green: 142/255, blue: 243/255, alpha: 1.0)
    public static let violet: UIColor = UIColor(red: 112/255, green: 112/255, blue: 239/255, alpha: 1.0)
    public static let darkViolet: UIColor = UIColor(red: 84/255, green: 84/255, blue: 205/255, alpha: 1.0)

    public static let lightDark: UIColor = UIColor(red: 81/255, green: 81/255, blue: 99/255, alpha: 1.0)
    public static let dark: UIColor = UIColor(red: 63/255, green: 63/255, blue: 77/255, alpha: 1.0)
    public static let veryDark: UIColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1.0)

    public static let lightGray: UIColor = UIColor(red: 244/255, green: 245/255, blue: 249/255, alpha: 1.0)
    public static let gray: UIColor = UIColor(red: 221/255, green: 226/255, blue: 239/255, alpha: 1.0)
    public static let darkGray: UIColor = UIColor(red: 192/255, green: 199/255, blue: 218/255, alpha: 1.0)

    public static let text: UIColor = UIColor(red: 87/255, green: 96/255, blue: 119/255, alpha: 1.0)
    public static let blackDimmed: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    public static let whiteDimmed: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
    
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
    public var font: UIFont = Palette.defaultFont
    
    public init() { }
    public init (font: UIFont) {
        self.font = font
    }
}

public class BackgroundAttribute {
    public var color: UIColor = UIColor.clear
    
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
    
    public init() { }
}


public class ImageAttribute {
    public var image: UIImage?
    
    public init() { }
    public init(image: UIImage) {
        self.image = image
    }
}
