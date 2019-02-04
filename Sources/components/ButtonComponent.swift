//
//  AttributedButton.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class ButtonComponent: UIButton {
    
    public var buttonRoleType: ButtonRoleType = .normal
    public var buttonGroup: ButtonGroupComponent? {
        willSet {
            do {
                try newButtonGroup(group: newValue)
            } catch {
                print(error)
            }
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                // radio button -> need to notify buttonGroup
                if buttonRoleType == .radio {
                    if let group = self.buttonGroup {
                        group.notifyButtonSelectedChange(self)
                    }
                }
                
                self.layer.backgroundColor = UIColor.red.cgColor
            } else {
                self.layer.backgroundColor = UIColor.gray.cgColor
            }
        }
    }
    
    @IBInspectable public var roleType: String = "normal" {
        willSet {
            if newValue == "radio" {
                self.buttonRoleType = .radio
            } else if newValue == "check" {
                self.buttonRoleType = .check
            } else {
                self.buttonRoleType = .normal
            }
        }
    }
    
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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        decorate()        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        decorate()
    }
    
    private func newButtonGroup(group: ButtonGroupComponent?) throws {
        guard group == nil else {
            throw NSError(domain: "ButtonComponent", code: 1,
                          userInfo: ["newButtonGroupError": "group already defined"])
        }
    }
    
    override public func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isSelected = !isSelected
        }
    }
    
    func decorate() {
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

public enum ButtonRoleType: Int {
    case normal = 1
    case radio = 2
    case check = 3
}
