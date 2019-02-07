//
//  PopupWidget.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 07/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class PopupWidget {
    
    public var okTitle: String = "OK"
    public var cancelTitle: String? = "Cancel"
    public var okButtonColor: UIColor = Palette.blue
    public var cancelButtonColor: UIColor? = Palette.lightDark
    
    private let view: UIView = UIView()
    private var headerLabel: UILabel? = nil
    private let contentLabel: UILabel = UILabel()
    private let okButton: UIButton = UIButton()
    private var cancelButton: UIButton? = nil
    private var closeButton: UIButton = UIButton()
    
    private let headerContentGap: CGFloat = 10.0
    private let contentButtonGap: CGFloat = 20.0
    private let animationDuration: TimeInterval = 0.3
    private var totalHeight: CGFloat = 0.0
    
    private let attribute: StyleAttribute
    
    init(header: String?, content: String, attribute: StyleAttribute?) {
        
        if attribute == nil {
            let attr = StyleAttribute()
            attr.backgroundAttribute.color = Palette.lightGray
            attr.textAttribute.color = Palette.text
            attr.textAttribute.letterSpacing = 1.2
            attr.boxAttribute.padding = CGFloat(10.0)
            attr.boxAttribute.borderRadius = 5.0
            attr.boxAttribute.marginLeft = 10.0
            attr.boxAttribute.marginRight = 10.0
            attr.boxAttribute.marginTop = 30.0
            
            self.attribute = attr
        } else {
            self.attribute = attribute!
        }
        
        // header
        if let header = header {
            self.headerLabel = UILabel()
            self.headerLabel!.text = header
            self.headerLabel!.sizeToFit()
            view.addSubview(self.headerLabel!)
        }
        
        // close button
        closeButton.frame = CGRect(x: 0, y: 0,
                                   width: 20.0,
                                   height: 20.0)
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        view.addSubview(self.closeButton)
        
        // content
        self.contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        view.addSubview(self.contentLabel)
        
        // attribute
        let attr = self.attribute
        
        let viewWidth = UIScreen.main.bounds.width
            - attr.boxAttribute.marginLeft
            - attr.boxAttribute.marginRight
        
        /// header setting
        if let h = headerLabel {
            h.frame = CGRect(x: attr.boxAttribute.paddingLeft,
                             y: attr.boxAttribute.paddingTop,
                             width: UIScreen.main.bounds.width
                                - attr.boxAttribute.paddingLeft
                                - attr.boxAttribute.paddingRight,
                             height: h.frame.height)
            
            h.textColor = attr.textAttribute.color
            h.font = attr.fontAttribute.font
            totalHeight += h.frame.height
        }
        
        /// content setting
        contentLabel.frame = CGRect(x: attr.boxAttribute.paddingLeft,
                                    y: totalHeight + headerContentGap,
                                    width: UIScreen.main.bounds.width
                                        - attr.boxAttribute.paddingLeft
                                        - attr.boxAttribute.paddingRight,
                                    height: contentLabel.frame.height)
        contentLabel.textColor = attr.textAttribute.color
        contentLabel.font = attr.fontAttribute.font
        contentLabel.sizeToFit()
        totalHeight += (contentLabel.frame.height + headerContentGap)
        
        /// button setting
        okButton.setTitle(okTitle, for: .normal)
        okButton.sizeToFit()
        self.okButton.frame = CGRect(x: viewWidth - attr.boxAttribute.paddingRight - okButton.frame.width - 20.0,
                                     y: totalHeight + contentButtonGap,
                                     width: self.okButton.frame.width + 20.0,   // padding 20
                                    height: self.okButton.frame.height)
        totalHeight += (okButton.frame.height + contentButtonGap)
        
        /// background view setting
        view.frame = CGRect(x: attr.boxAttribute.marginLeft,
                            y: attr.boxAttribute.marginTop,
                            width: UIScreen.main.bounds.width
                                - attr.boxAttribute.marginLeft
                                - attr.boxAttribute.marginRight,
                            height: totalHeight     // header height + content height + button height
                                + attr.boxAttribute.paddingTop
                                + attr.boxAttribute.paddingBottom)
        
        view.backgroundColor = attr.backgroundAttribute.color
        view.layer.cornerRadius = attr.boxAttribute.borderRadius
        
        
        /// close button
        /// top right side of the view.
        closeButton.frame.origin.x = self.view.frame.width
            - attr.boxAttribute.paddingRight
            - closeButton.frame.width
        closeButton.frame.origin.y = attr.boxAttribute.paddingTop
    }
    
    public func show(_ target: UIViewController) {
        // button setting
        var cornerRadius = attribute.boxAttribute.borderRadius
        if attribute.boxAttribute.borderRadius > self.okButton.frame.height / 2 {
            cornerRadius = self.okButton.frame.height / 2
        }
        
        self.okButton.setTitle(self.okTitle, for: .normal)
        self.okButton.backgroundColor = self.okButtonColor
        self.okButton.titleLabel!.font = attribute.fontAttribute.font
        self.okButton.layer.cornerRadius = cornerRadius
        self.view.addSubview(self.okButton)
        
        if let cancelTitle = self.cancelTitle {
            self.cancelButton = UIButton()
            self.cancelButton?.setTitle(cancelTitle, for: .normal)
            self.cancelButton?.backgroundColor = self.cancelButtonColor
            self.cancelButton?.titleLabel!.font = attribute.fontAttribute.font
            self.cancelButton?.layer.cornerRadius = cornerRadius
            self.cancelButton?.sizeToFit()
            
            // cancel is left of the ok button
            self.cancelButton?.frame = CGRect(x: self.okButton.frame.origin.x
                - self.cancelButton!.frame.width - 10.0 - 20.0,
                                              y: self.okButton.frame.origin.y,
                                              width: self.cancelButton!.frame.width + 20.0,
                                              height: self.cancelButton!.frame.height)
            
            self.view.addSubview(self.cancelButton!)
        }
        
        /// animation
        let originalFrame = self.view.frame
        self.view.frame = CGRect(x: originalFrame.origin.x,
                                 y: -originalFrame.height,
                                 width: originalFrame.width,
                                 height: originalFrame.height)
        target.view.addSubview(self.view)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        self.view.frame = originalFrame
                        
        }, completion: nil)
    }
    
    public func close() {
        self.view.removeFromSuperview()
    }
}
