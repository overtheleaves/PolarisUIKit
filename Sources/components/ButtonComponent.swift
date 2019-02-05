//
//  AttributedButton.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class ButtonComponent: UIButton {
    
    private let stateMapping:[LinkState:[State]] = [.normal: [.normal],
                                            .hover: [.highlighted],
                                            .pressed: [.selected],
                                            .disabled: [.disabled]]
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
    
    @IBInspectable public var styleType: String? {
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
        guard self.buttonGroup == nil else {
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
        
        
        
        // Stateless attribute
        if let val = self.styleAttr.type,
            let attribute = Palette.getAttribute(name: val, linkState: .normal) {
            
            self.styleAttr.attribute = attribute
 
            // Font Attribute
            //
            // - font
            if let label = self.titleLabel {
                label.font = attribute.fontAttribute.font
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
        }
        
        // Stateful attribute
        var imageWidthRatio: CGFloat? = nil
        
        if let val = self.styleAttr.type {
            
            for (linkState, uiStates) in stateMapping {
                
                if let attribute = Palette.getAttribute(name: val, linkState: linkState) {
                    
                    // UIControl.State
                    for uiState in uiStates {
                        
                        // Text Attribute
                        //
                        // - text color
                        self.setTitleColor(attribute.textAttribute.color, for: uiState)
                        
                        // - letter spacing
                        if let text = self.currentAttributedTitle {
                            let attrString = NSMutableAttributedString(attributedString: text)
                            attrString.addAttribute(NSAttributedString.Key.kern,
                                                    value: attribute.textAttribute.letterSpacing,
                                                    range: NSRange(location: 0, length: text.length))
                            self.setAttributedTitle(attrString.attributedSubstring(from: NSRange(location: 0, length: text.length)),
                                                    for: uiState)
                        }
                        
                        /// Image Attribute
                        ///
                        /// - image
                        if let imageAttribute = attribute.imageAttribute,
                            let image = imageAttribute.image {
                            
                            if imageWidthRatio == nil {
                                imageWidthRatio = image.size.height / image.size.width
                            }
                            self.setImage(image, for: uiState)                            
                        }
                    }
                }
            }
        }
        
        /// Image Attribute
        if let iv = self.imageView,
            let imageWidthRatio = imageWidthRatio {
            
            iv.frame = CGRect(x: 0, y: 0,
                              width: self.frame.height * imageWidthRatio,
                              height: self.frame.height)
            
            iv.contentMode = .scaleAspectFit
            
            let leftRightInset = iv.frame.width * 0.1    // 10% of width
            let topBottomInset = iv.frame.height * 0.1   // 10% of height
            
            self.imageEdgeInsets = UIEdgeInsets(top: topBottomInset,
                                                left: leftRightInset,
                                                bottom: topBottomInset,
                                                right: leftRightInset)
        }
        
        self.tintColor = UIColor.clear
        self.invalidateIntrinsicContentSize()
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
