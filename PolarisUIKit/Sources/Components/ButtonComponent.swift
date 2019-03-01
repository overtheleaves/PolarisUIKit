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
    public var imageTitleGap: CGFloat = 10.0
    
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
   
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isSelected = !isSelected
        }
    }
    
    func decorate() {
        
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        
        // Stateless attribute
        if let attribute = Palette.getAttribute(name: self.styleAttr.type, linkState: .normal) {
            
            self.styleAttr.attribute = attribute
            
            // Font Attribute
            //
            // - font
            if let label = self.titleLabel {
                label.font = attribute.fontAttribute.font
            }
            
            Palette.decorateLayer(self.layer, view: self, attribute: attribute)
            
            // - padding
            self.contentEdgeInsets = UIEdgeInsets(top: attribute.boxAttribute.paddingTop,
                                                  left: attribute.boxAttribute.paddingLeft,
                                                  bottom: attribute.boxAttribute.paddingBottom,
                                                  right: attribute.boxAttribute.paddingRight)

        }
        
        // Stateful attribute
        var imageWidthRatio: CGFloat? = nil
        var titleHeight: CGFloat = self.frame.height
        
        if let titleLabel = self.titleLabel {
            titleHeight = titleLabel.frame.height < titleHeight ? titleLabel.frame.height : titleHeight
        }
        
        
        for (linkState, uiStates) in stateMapping {
            
            if let attribute = Palette.getAttribute(name: self.styleAttr.type, linkState: linkState) {
                
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
                        
                        // image resizing
                        if let resizedImage = resizeImage(with: image,
                                                          size: CGSize(width: titleHeight * imageWidthRatio!, height: titleHeight)) {
                            self.setImage(resizedImage.withRenderingMode(.alwaysOriginal),
                                      for: uiState)
                        } else {
                            self.setImage(image, for: uiState)
                        }
                    }
                }
            }
        }
        
        /// Image Attribute
        if let iv = self.imageView,
            let imageWidthRatio = imageWidthRatio {
            
            let width: CGFloat = titleHeight * imageWidthRatio
            let height: CGFloat = titleHeight
            
            /// default image undefined
            if self.image(for: .normal) == nil {                
                self.setImage(emptyImage(with: CGSize(width: width,
                                                      height: height)), for: .normal)
            }
            
            iv.frame = CGRect(x: 0, y: 0,
                              width: width,
                              height: height)
            
            //iv.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            iv.layer.cornerRadius = 2.0
            
            iv.contentMode = .scaleAspectFit
            
            if title(for: .normal) != nil {
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleGap, bottom: 0, right: -imageTitleGap)
                self.contentEdgeInsets.right += imageTitleGap
            }
        }
        
        self.tintColor = UIColor.clear
        self.sizeToFit()
    }
    
    func resizeImage(with image: UIImage, size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            
            context.translateBy(x: 0.0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0);
            context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return scaledImage
        }
        return nil
    }
    
    func emptyImage(with size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(size)
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

public enum ButtonRoleType: Int {
    case normal = 1
    case radio = 2
    case check = 3
}
