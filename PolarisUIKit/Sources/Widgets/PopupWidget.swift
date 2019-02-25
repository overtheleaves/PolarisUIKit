//
//  PopupWidget.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 07/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class PopupWidget {
    
    public typealias CloseHandler = () -> Void
    public typealias CompleteHandler = (Bool) -> Void
    public static var isModalOpen: Bool = false
    
    private static var widget: InternalPopupWidget?
    
    public static func show(_ target: UIViewController,
                            header: String?,
                            content: String,
                            attribute: StyleAttribute?,
                            close: CloseHandler? = nil,
                            completion: CompleteHandler? = nil) -> Bool {
        
        if PopupWidget.isModalOpen {
            return false
        }
        
        widget = InternalPopupWidget(header: header, content: content, attribute: attribute)
        
        let viewController = UIViewController()
        viewController.modalPresentationStyle = .overFullScreen
        target.present(viewController, animated: false, completion: { () in
            widget!.show(viewController, close: close, completion: completion)
        })
        
        return true
    }
}

class InternalPopupWidget {
   
    public var okTitle: String = "OK"
    public var cancelTitle: String? = "Cancel"
    public var okButtonColor: UIColor = Palette.blue
    public var cancelButtonColor: UIColor? = Palette.lightDark
    public var widgetAnimator: WidgetAnimator = DefaultWidgetAnimator()
    
    private let view: UIView = UIView()
    private let backgroundView: UIView = UIView(frame: UIScreen.main.bounds)
    private var headerLabel: UILabel? = nil
    private let contentLabel: UILabel = UILabel()
    private let okButton: UIButton = UIButton(type: .custom)
    private var cancelButton: UIButton? = nil
    private var closeButton: UIButton = UIButton(type: .custom)
    
    private let headerContentGap: CGFloat = 10.0
    private let contentButtonGap: CGFloat = 20.0
    private let okCancelButtonGap: CGFloat = 10.0
    private let buttonLeftRightPadding: CGFloat = 10.0
    private let animationDuration: TimeInterval = 0.4
    private var totalHeight: CGFloat = 0.0
    
    private var closeHandler: PopupWidget.CloseHandler?
    private var completeHandler: PopupWidget.CompleteHandler?
    private var currentViewController: UIViewController?
    
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
        
        // background view
        backgroundView.backgroundColor = Palette.blackDimmed
        backgroundView.isUserInteractionEnabled = false // disable dimmed area
        
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
            h.font = attr.fontAttribute.font.bold()
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
        self.okButton.frame = CGRect(x: viewWidth
                                        - attr.boxAttribute.paddingRight
                                        - okButton.frame.width
                                        - buttonLeftRightPadding * 2,
                                     y: totalHeight + contentButtonGap,
                                     width: self.okButton.frame.width + buttonLeftRightPadding * 2,   // padding 20
                                    height: self.okButton.frame.height)
        totalHeight += (okButton.frame.height + contentButtonGap)
        
        /// content view setting
        let totalContentViewHeight = totalHeight     // header height + content height + button height
            + attr.boxAttribute.paddingTop
            + attr.boxAttribute.paddingBottom
        let viewY: CGFloat = (UIScreen.main.bounds.height - (totalContentViewHeight)) / 2
        
        view.frame = CGRect(x: attr.boxAttribute.marginLeft,
                            y: viewY,
                            width: UIScreen.main.bounds.width
                                - attr.boxAttribute.marginLeft
                                - attr.boxAttribute.marginRight,
                            height: totalContentViewHeight)
        
        view.backgroundColor = attr.backgroundAttribute.color
        view.layer.cornerRadius = attr.boxAttribute.borderRadius
        
        
        /// close button
        /// top right side of the view.
        closeButton.frame.origin.x = self.view.frame.width
            - attr.boxAttribute.paddingRight
            - closeButton.frame.width
        closeButton.frame.origin.y = attr.boxAttribute.paddingTop
        
        /// event handler
        closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
    }
    
    public func show(_ target: UIViewController, close: PopupWidget.CloseHandler? = nil, completion: PopupWidget.CompleteHandler? = nil) {
        
        PopupWidget.isModalOpen = true
        
        self.closeHandler = close
        self.completeHandler = completion
        self.currentViewController = target
        
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
            self.cancelButton = UIButton(type: .custom)
            self.cancelButton?.setTitle(cancelTitle, for: .normal)
            self.cancelButton?.backgroundColor = self.cancelButtonColor
            self.cancelButton?.titleLabel!.font = attribute.fontAttribute.font
            self.cancelButton?.layer.cornerRadius = cornerRadius
            self.cancelButton?.sizeToFit()
            
            // cancel is left of the ok button
            self.cancelButton?.frame = CGRect(x: self.okButton.frame.origin.x
                                                - self.cancelButton!.frame.width
                                                - okCancelButtonGap
                                                - buttonLeftRightPadding * 2,
                                              y: self.okButton.frame.origin.y,
                                              width: self.cancelButton!.frame.width
                                                + buttonLeftRightPadding * 2,
                                              height: self.okButton.frame.height)
            
            self.view.addSubview(self.cancelButton!)
        }
        
        /// event handler
        okButton.addTarget(self, action: #selector(pressOk) , for: .touchUpInside)
        if let btn = cancelButton {
            btn.addTarget(self, action: #selector(pressCancel), for: .touchUpInside)
        }
        
        target.view.addSubview(self.backgroundView)
        target.view.addSubview(self.view)
        
        widgetAnimator.show(self.backgroundView, showFrom: .FadeIn, completion: nil)
        widgetAnimator.show(self.view, showFrom: .FromTop, completion: nil)
    }
    
    private func hide() {
        widgetAnimator.hide(self.backgroundView, hideTo: .FadeOut, completion: nil)
        widgetAnimator.hide(self.view, hideTo: .ToTop) { (success) in
            PopupWidget.isModalOpen = false
            self.view.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
            
            if let vc = self.currentViewController {
                vc.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc func close(_ sender: UIButton?) {
        if let handler = self.closeHandler {
            handler()
        }
        
        hide()
    }
    
    @objc func pressOk() {
        if let handler = self.completeHandler {
            handler(true)
        }
        
        hide()
    }
    
    @objc func pressCancel() {
        if let handler = self.completeHandler {
            handler(false)
        }
        
        hide()
    }
}
