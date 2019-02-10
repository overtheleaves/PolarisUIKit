//
//  AttributedTextView.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class TextViewComponent: UITextView {
    
    @IBInspectable public var styleType: String {
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
        if let attribute = Palette.getAttribute(name: self.styleAttr.type) {
            
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
            
//
//            // Background Attribute
//            //
//            // - background color
//            self.layer.backgroundColor = attribute.backgroundAttribute.color.cgColor
//
//
//            // Border Attribute
//            //
//            // - corner radius
//            self.layer.cornerRadius = attribute.boxAttribute.borderRadius
//
//
//            // - border
//            self.layer.borderWidth = attribute.boxAttribute.borderWidth
//            self.layer.borderColor = attribute.boxAttribute.borderColor.cgColor
//

            Palette.decorateLayer(self.layer, view: self, attribute: attribute)
            self.layer.masksToBounds = true 
            
            // - padding
            self.textContainerInset.top = attribute.boxAttribute.paddingTop
            self.textContainerInset.bottom = attribute.boxAttribute.paddingBottom
            self.textContainerInset.left = attribute.boxAttribute.paddingLeft
            self.textContainerInset.right = attribute.boxAttribute.paddingRight
        }
    }
}
