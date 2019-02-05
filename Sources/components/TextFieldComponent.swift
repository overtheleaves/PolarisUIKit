//
//  AttributedTextField.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class TextFieldComponent: UITextField {

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
            
            /// Font Attribute
            ///
            /// - font
            self.font = attribute.fontAttribute.font
            
            /// Text Attribute
            ///
            /// - text color
            self.textColor = attribute.textAttribute.color
            
            // - letter spacing
            if let text = self.attributedText {
                let attrString = NSMutableAttributedString(attributedString: text)
                attrString.addAttribute(NSAttributedString.Key.kern,
                                        value: attribute.textAttribute.letterSpacing,
                                        range: NSRange(location: 0, length: text.length))
                self.attributedText = attrString.attributedSubstring(from: NSRange(location: 0, length: text.length))
            }
            
            
            /// Box Attribute
            ///
            /// box layer
            let decorateLayer = CALayer()
            Palette.decorateLayer(decorateLayer, view: self, attribute: attribute)
            
            decorateLayer.frame = getAttributedPaddingRect(original: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.height))
            
            self.layer.addSublayer(decorateLayer)
            self.layer.masksToBounds = true
            
            /// original border style clear
            self.borderStyle = .none
        }
    }
    
    /// Box Attribute
    ///
    /// - padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let original = super.textRect(forBounds: bounds)
        return getAttributedPaddingRect(original: original)
    }
    
    /// Box Attribute
    ///
    /// - padding
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let original = super.editingRect(forBounds: bounds)
        return getAttributedPaddingRect(original: original)
    }
    
    /// Box Attribute
    ///
    /// - padding
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let original = super.placeholderRect(forBounds: bounds)
        return getAttributedPaddingRect(original: original)
    }
    
    /// Box Attribute
    ///
    /// - padding
    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        let original = super.borderRect(forBounds: bounds)
        return getAttributedPaddingRect(original: original)
    }
}
