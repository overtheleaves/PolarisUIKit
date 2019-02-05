//
//  AttributedUILabel.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 03/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class LabelComponent: UILabel {
    
   @IBInspectable public var type: String? {
        get {
            return self.styleAttr.type
        }
        set {
            if self.styleAttr.type != newValue {
                self.styleAttr.type = newValue
                decorate()
            }
        }
    }
    
    func decorate() {
        if let val = self.styleAttr.type, let attribute = Palette.getAttribute(name: val) {
            
            self.styleAttr.attribute = attribute
            
            // Font Attribute
            //
            // - font
            self.font = attribute.fontAttribute.font
            
            
            // Text Attribute
            //
            // - text color
            self.textColor = attribute.textAttribute.color
            
            // - letter spacing
            if let text = self.attributedText {
                let attrString = NSMutableAttributedString(attributedString: text)
                attrString.addAttribute(NSAttributedString.Key.kern,
                                        value: attribute.textAttribute.letterSpacing,
                                        range: NSRange(location: 0, length: text.length))
                self.attributedText = attrString.attributedSubstring(from: NSRange(location: 0, length: text.length))
            }
            
            
            // Background Attribute
            //
            // - background color
            self.layer.backgroundColor = attribute.backgroundAttribute.color.cgColor
            
            
            // Box Attribute
            //
            // - corner radius
            self.layer.cornerRadius = attribute.boxAttribute.borderRadius
            
            // - border
            self.layer.borderWidth = attribute.boxAttribute.borderWidth
            self.layer.borderColor = attribute.boxAttribute.borderColor.cgColor
            
            self.sizeToFit()
        }
    }
    
    // Box Attribute
    //
    // - padding
    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        if let attribute = self.styleAttr.attribute {
            let insets = UIEdgeInsets(top: attribute.boxAttribute.paddingTop,
                                      left: attribute.boxAttribute.paddingLeft,
                                      bottom: attribute.boxAttribute.paddingBottom,
                                      right: attribute.boxAttribute.paddingRight)
            
            let textRect = super.textRect(forBounds: bounds.inset(by: insets),
                                          limitedToNumberOfLines: numberOfLines)
            
            let invertedInsets = UIEdgeInsets(top: -attribute.boxAttribute.paddingTop,
                                              left: -attribute.boxAttribute.paddingLeft,
                                              bottom: -attribute.boxAttribute.paddingBottom,
                                              right: -attribute.boxAttribute.paddingRight)
            
            return textRect.inset(by: invertedInsets)

        } else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
    }
    
    // Box Attribute
    //
    // - padding 
    override public func drawText(in rect: CGRect) {
        
        if let attribute = self.styleAttr.attribute {
            let insets = UIEdgeInsets(top: attribute.boxAttribute.paddingTop,
                                    left: attribute.boxAttribute.paddingLeft,
                                    bottom: attribute.boxAttribute.paddingBottom,
                                    right: attribute.boxAttribute.paddingRight)
            
            super.drawText(in: rect.inset(by: insets))
        } else {
            super.drawText(in: rect)
        }
    }
}
