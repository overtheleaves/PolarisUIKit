//
//  AttributedButton.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class AttributedButton: UIButton {
    
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
            if let label = self.titleLabel {
                label.font = attribute.fontAttribute.font
            }
            
            
            // Text Attribute
            //
            // - text color
            self.setTitleColor(attribute.textAttribute.color, for: .normal)
            
            // - letter spacing
            if let text = self.currentAttributedTitle {
                let attrString = NSMutableAttributedString(attributedString: text)
                attrString.addAttribute(NSAttributedString.Key.kern,
                                        value: attribute.textAttribute.letterSpacing,
                                        range: NSRange(location: 0, length: text.length))
                self.setAttributedTitle(attrString.attributedSubstring(from: NSRange(location: 0, length: text.length)),
                                        for: .normal)
            }
            
            
            // Background Attribute
            //
            // - background color
            self.layer.backgroundColor = attribute.backgroundAttribute.color.cgColor
            
            
            // Box Attribute
            //
            // - corner radius
            self.layer.cornerRadius = attribute.boxAttribute.borderRadius
            
            // - padding
            self.contentEdgeInsets.top = attribute.boxAttribute.paddingTop
            self.contentEdgeInsets.bottom = attribute.boxAttribute.paddingBottom
            self.contentEdgeInsets.left = attribute.boxAttribute.paddingLeft
            self.contentEdgeInsets.right = attribute.boxAttribute.paddingRight
            
            // - border
            self.layer.borderWidth = attribute.boxAttribute.borderWidth
            self.layer.borderColor = attribute.boxAttribute.borderColor.cgColor
            
            
            //self.sizeToFit()
            self.invalidateIntrinsicContentSize()
            self.setNeedsDisplay()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        get {
            let original = super.intrinsicContentSize
            
            if let attribute = self.styleAttr.attribute {
            return CGSize(width: original.width
                            + attribute.boxAttribute.paddingLeft
                            + attribute.boxAttribute.paddingRight,
                          height: original.height
                            + attribute.boxAttribute.paddingTop
                            + attribute.boxAttribute.paddingBottom)
            } else {
                return original
            }
        }
    }
}
