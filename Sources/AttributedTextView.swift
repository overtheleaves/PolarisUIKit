//
//  AttributedTextView.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class AttributedTextView: UITextView {
    
    @IBInspectable public var type: String? {
        get {
            return self.styleAttr.type
        }
        set {
            if self.styleAttr.type != newValue {
                self.styleAttr.type = newValue
                initialize()
            }
        }
    }
    
    func initialize() {
        if let val = self.styleAttr.type, let attribute = Palette.getAttribute(id: val) {
            
            self.styleAttr.attribute = attribute
            
            // Font Attribute
            //
            // - font
            self.font = attribute.fontAttribute.font
          
            
            // Background Attribute
            //
            // - background color
            self.layer.backgroundColor = attribute.backgroundAttribute.color.cgColor
            
            
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
            
            
            // Border Attribute
            //
            // - corner radius
            self.layer.cornerRadius = attribute.boxAttribute.borderRadius
            
            // - padding
            self.textContainerInset.top = attribute.boxAttribute.paddingTop
            self.textContainerInset.bottom = attribute.boxAttribute.paddingBottom
            self.textContainerInset.left = attribute.boxAttribute.paddingLeft
            self.textContainerInset.right = attribute.boxAttribute.paddingRight
            
            // - border
            self.layer.borderWidth = attribute.boxAttribute.borderWidth
            self.layer.borderColor = attribute.boxAttribute.borderColor.cgColor            
        }
    }
}
