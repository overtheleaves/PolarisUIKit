//
//  DropdownComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 13/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit
import PolarisFramework

public class DropdownComponent: UIControl {
    
    //    public typealias MenuSelectedHandler = (Int) -> Void
    
    public enum Direction {
        case vertical
        case horizontal
    }
    
    private var selection: Int = 0 {
        didSet {
           // self.placeholderView?.removeFromSuperview()
            if let snapshot = self.menuViews[selection].snapshotView(afterScreenUpdates: false) {
           //     self.placeholderWrapperView.addSubview(snapshot)
                self.placeholderView = snapshot
            }
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var placeholderAttribute: StyleAttribute?
    private var _placeholderStyleType: String = ""
    @IBInspectable public var placeholderStyleType: String {
        get { return _placeholderStyleType }
        set {
            _placeholderStyleType = newValue
            if let attr = Palette.getAttribute(name: newValue) {
                if attr !== self.placeholderAttribute {
                    self.placeholderAttribute = attr
                    placeholderDecorate()
                }
            }
        }
    }
    
    private var dropdownMenuWrapperAttribute: StyleAttribute?
    private var _dropdownMenuWrapperStyleType: String = ""
    @IBInspectable public var dropdownMenuWrapperStyleType: String {
        get { return _dropdownMenuWrapperStyleType }
        set {
            _dropdownMenuWrapperStyleType = newValue
            if let attr = Palette.getAttribute(name: newValue) {
                if attr !== self.dropdownMenuWrapperAttribute {
                    self.dropdownMenuWrapperAttribute = attr
                    dropdownMenuWrapperDecorate()
                }
            }
        }
    }
    
    private var dropdownMenuWrapperView: ViewComponent = ViewComponent()
    private var dropdownMenuContentView: UIStackView = UIStackView()
    public var direction: DropdownComponent.Direction = .vertical {
        didSet {
            switch direction {
            case .vertical:
                self.dropdownMenuContentView.axis = .vertical
            case .horizontal:
                self.dropdownMenuContentView.axis = .horizontal
            }
        }
    }
    
    //    public var menuSelectedHandler: MenuSelectedHandler?
    
    private var placeholderWrapperView: UIView = UIView()
    public var placeholderView: UIView? {
        didSet {
            if let removeView = oldValue {
                removeView.removeFromSuperview()
            }
            
            if let newView = placeholderView {
                self.placeholderWrapperView.addSubview(newView)
                newView.isUserInteractionEnabled = false
            }
        }
    }
    
    public var onRightIconColor: UIColor = Palette.lightGray {
        didSet {
            // change current color
            if isOpened {
                self.rightIconImageView.maskImageColor(color: self.onRightIconColor)
            }
        }
    }
    public var offRightIconColor: UIColor = Palette.lightGray {
        didSet {
            if !isOpened {
                self.rightIconImageView.maskImageColor(color: self.offRightIconColor)
            }
        }
    }
    
    private var rightIconImageViewTopAnchorConstraint: NSLayoutConstraint? {
        willSet { self.rightIconImageViewTopAnchorConstraint?.isActive = false }
        didSet { self.rightIconImageViewTopAnchorConstraint?.isActive = true }
    }
    
    private var rightIconImageViewBottomAnchorConstraint: NSLayoutConstraint? {
        willSet { self.rightIconImageViewBottomAnchorConstraint?.isActive = false }
        didSet { self.rightIconImageViewBottomAnchorConstraint?.isActive = true }
    }
   
    private var rightIconImageViewTrailingAnchorConstraint: NSLayoutConstraint? {
        willSet { self.rightIconImageViewTrailingAnchorConstraint?.isActive = false }
        didSet { self.rightIconImageViewTrailingAnchorConstraint?.isActive = true }
    }
    
    private var rightIconImageViewWidthAnchorConstraint: NSLayoutConstraint? {
        willSet { self.rightIconImageViewWidthAnchorConstraint?.isActive = false }
        didSet {  self.rightIconImageViewWidthAnchorConstraint?.isActive = true }
    }
    
    private var rightIconImageViewHeightAnchorConstraint: NSLayoutConstraint? {
        willSet { self.rightIconImageViewHeightAnchorConstraint?.isActive = false }
        didSet { self.rightIconImageViewHeightAnchorConstraint?.isActive = true }
    }
    
    public var onOffRightIconsInsets: UIEdgeInsets! {
        didSet {
            self.rightIconImageViewTopAnchorConstraint = self.rightIconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.onOffRightIconsInsets.top)
            self.rightIconImageViewTrailingAnchorConstraint = self.rightIconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.onOffRightIconsInsets.right)
            self.rightIconImageViewBottomAnchorConstraint = self.rightIconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.onOffRightIconsInsets.bottom)
            
            adjustRightImageView()
        }
    }
    
    public var onOffRightIcons: (on: UIImage, off: UIImage)?
    {
        didSet {
            if let icons = self.onOffRightIcons {
                self.rightIconImageView.image = icons.off
                adjustRightImageView()
            }
        }
    }
    
    private let rightIconImageView: UIImageView = UIImageView()
    
    private var isOpened: Bool = false {
        didSet {
            if isOpened {
                
                if let icons = self.onOffRightIcons {
                    // show after animation
                    UIView.transition(with: rightIconImageView, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                        self.rightIconImageView.image = icons.on
                        self.rightIconImageView.maskImageColor(color: self.onRightIconColor)
                    }, completion: {(success) in
                        self.showDropdownMenu()
                    })
                } else {
                    self.showDropdownMenu()
                }
                
            } else {
                
                if let icons = self.onOffRightIcons {
                    // hide after animation
                    UIView.transition(with: rightIconImageView, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                        self.rightIconImageView.image = icons.off
                        self.rightIconImageView.maskImageColor(color: self.offRightIconColor)
                    }, completion: { (success) in
                        self.hideDropdownMenu()
                    })
                } else {
                    self.hideDropdownMenu()
                }
            }
        }
    }
    private var menuViews: [UIControl] = []
    private var target: UIView?
    private let widgetAnimator: WidgetAnimator = DefaultWidgetAnimator()
    
    // constraints
    var dropdownMenuWrapperViewWidthConstraint: NSLayoutConstraint?
    var dropdownMenuWrapperViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        /// placeholder wrapper
        self.addSubview(self.placeholderWrapperView)
        
        /// dropdown menu content view
        self.dropdownMenuContentView.axis = .vertical
        self.dropdownMenuContentView.distribution = .equalSpacing
        self.dropdownMenuContentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.dropdownMenuWrapperView.translatesAutoresizingMaskIntoConstraints = false
        self.dropdownMenuWrapperView.clipsToBounds = true
        self.dropdownMenuWrapperView.addSubview(self.dropdownMenuContentView)
        
        self.dropdownMenuContentView.topAnchor.constraint(equalTo: self.dropdownMenuWrapperView.topAnchor).isActive = true
        
        self.dropdownMenuContentView.bottomAnchor.constraint(equalTo: self.dropdownMenuWrapperView.bottomAnchor).isActive = true
        
        self.dropdownMenuContentView.leadingAnchor.constraint(equalTo: self.dropdownMenuWrapperView.leadingAnchor).isActive = true
        
        /// right icon imageview
        self.rightIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(rightIconImageView)
        self.bringSubviewToFront(rightIconImageView)
        self.rightIconImageView.contentMode = .scaleAspectFit
        self.onOffRightIconsInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    
    func adjustRightImageView() {
        let originalImageWidth = self.rightIconImageView.image?.size.width ?? 1
        let originalImageHeight = self.rightIconImageView.image?.size.height ?? 1
        let imageRatio: CGFloat =  originalImageWidth / originalImageHeight
        let imageHeight: CGFloat = self.frame.height - (self.onOffRightIconsInsets.top + self.onOffRightIconsInsets.bottom)
        let imageWidth: CGFloat = imageHeight * imageRatio
        
        self.rightIconImageViewHeightAnchorConstraint = self.rightIconImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        self.rightIconImageViewWidthAnchorConstraint = self.rightIconImageView.widthAnchor.constraint(equalToConstant: imageWidth)
    }
    
    func placeholderDecorate() {
        if let attr = self.placeholderAttribute {
            Palette.decorateLayer(self.layer, view: self, attribute: attr)
        }
    }
    
    
    func dropdownMenuWrapperDecorate() {
        if let attr = self.dropdownMenuWrapperAttribute {
            Palette.decorateLayer(self.dropdownMenuWrapperView.layer,
                                  view: self.dropdownMenuWrapperView,
                                  attribute: attr)
        }
    }
    
    
    /// touch event
    ///
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.isOpened = !self.isOpened
        return true
    }
    
    
    public func addMenuViews(_ target: UIView, menuContentViews: [UIView]) {
        
        for view in menuContentViews {
            let control = UIControl(frame: CGRect(x: view.frame.origin.x,
                                                  y: view.frame.origin.y,
                                                  width: view.frame.width,
                                                  height: view.frame.height))
            control.addSubview(view)
            self.menuViews.append(control)
        }
        
        self.target = target
        
        // remove targets
        for view in self.dropdownMenuContentView.subviews {
            if let menu = view as? UIControl {
                menu.removeTarget(self, action: #selector(menuSelected(_:)), for: .touchUpInside)
            }
        }
        
        // remove all views
        for view in self.dropdownMenuContentView.subviews {
            view.removeFromSuperview()
        }
        
        for menu in self.menuViews {
            menu.translatesAutoresizingMaskIntoConstraints = false
            
            self.dropdownMenuContentView.addArrangedSubview(menu)
            
            // intrinsic content size
            menu.widthAnchor.constraint(equalToConstant: menu.frame.width).isActive = true
            menu.heightAnchor.constraint(equalToConstant: menu.frame.height).isActive = true
            
            // add touch event target
            menu.addTarget(self, action: #selector(menuSelected(_:)), for: .touchUpInside)
        }
        
        self.dropdownMenuContentView.sizeToFit()
        
        // add view
        target.addSubview(self.dropdownMenuWrapperView)
    }
    
    
    /// show dropdown menu
    ///
    func showDropdownMenu() {
        if let target = self.target {
            let toggleViewFrame = self.frame
            
            let targetWidth = target.frame.width
            let targetHeight = target.frame.height
            let toggleViewX = toggleViewFrame.origin.x    // x of toggle view
            let toggleViewY = toggleViewFrame.origin.y    // y of toggle view
            let toggleViewHeight = self.frame.height
            let contentViewSize = stackViewSize(self.dropdownMenuContentView)
            
            if let widthConstraint = dropdownMenuWrapperViewWidthConstraint {
                widthConstraint.isActive = false
            }
            
            if let heightConstraint = dropdownMenuWrapperViewHeightConstraint {
                heightConstraint.isActive = false
            }
            
            self.dropdownMenuWrapperViewWidthConstraint = self.dropdownMenuWrapperView.widthAnchor.constraint(equalToConstant: contentViewSize.width)
            self.dropdownMenuWrapperViewHeightConstraint =  self.dropdownMenuWrapperView.heightAnchor.constraint(equalToConstant: contentViewSize.height)
            
            self.dropdownMenuWrapperViewWidthConstraint!.isActive = true
            self.dropdownMenuWrapperViewHeightConstraint!.isActive = true
            
            // 1. check width and add leading or trailing anchor
            if toggleViewX + contentViewSize.width > targetWidth {
                // dropdownMenuContentView will be exceeded screen width.
                // use trailingAnchor
                self.dropdownMenuWrapperView.trailingAnchor
                    .constraint(equalTo: self.trailingAnchor,
                                constant: 0)
                    .isActive = true
            } else {
                // not exceed, use leadingAnchor
                self.dropdownMenuWrapperView.leadingAnchor
                    .constraint(equalTo: self.leadingAnchor,
                                constant: 0)
                    .isActive = true
            }
            
            // 2. check height and add top or bottom anchor
            if toggleViewY + toggleViewHeight + contentViewSize.height > targetHeight {
                // dropdownMenuContentView will be exceeded screen height
                // use bottonAnchor
                self.dropdownMenuWrapperView.bottomAnchor
                    .constraint(equalTo: self.topAnchor,
                                constant: contentViewSize.height / 2 - 2)
                    .isActive = true
                setAnchorPoint(self.dropdownMenuWrapperView.layer, anchorPoint: CGPoint(x: 0.5, y: 1))
            } else {
                // not exceed, use topAnchor
                self.dropdownMenuWrapperView.topAnchor
                    .constraint(equalTo: self.bottomAnchor,
                                constant: -contentViewSize.height / 2 + 2)
                    .isActive = true
                
                setAnchorPoint(self.dropdownMenuWrapperView.layer, anchorPoint: CGPoint(x: 0.5, y: 0))
            }
            
            self.dropdownMenuWrapperView.layoutIfNeeded()
            
            widgetAnimator.show(self.dropdownMenuWrapperView,
                                showFrom: .FadeInScale, completion: nil)
        }
    }
    
    
    /// menu selected event handler
    ///
    @objc func menuSelected(_ sender: UIButton) {
        var i = -1
        
        for index in 0..<self.menuViews.count {
            let menu = self.menuViews[index]
            if menu === sender {
                i = index
                break
            }
        }
        
        //setSelection(index: i, invokeSelectedHandler: true)
        self.selection = i
        self.isOpened = false
    }
    
    
    //    public func setSelection(index: Int, invokeSelectedHandler: Bool) {
    
    //self.selection = index
    
    // replace placeholder
    //        self.placeholderView?.removeFromSuperview()
    //        if let snapshot = self.menuViews[index].snapshotView(afterScreenUpdates: false) {
    //            self.placeholderWrapperView.addSubview(snapshot)
    //        }
    
    //        if invokeSelectedHandler {
    //            if let handler = menuSelectedHandler {
    //                handler(index)
    //            }
    //        }
    //    }
    
    
    /// hide dropdown menu
    ///
    func hideDropdownMenu() {
        widgetAnimator.hide(self.dropdownMenuWrapperView,
                            hideTo: .FadeOutScale, completion: nil)
    }
    
    
    func setAnchorPoint(_ layer: CALayer, anchorPoint point: CGPoint) {
        let bounds = layer.bounds
        
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
    
    
    func stackViewSize(_ stackView: UIStackView) -> CGSize {
        if stackView.axis == .vertical {
            var maxWidth: CGFloat = 0.0
            var totalHeight: CGFloat = 0.0
            for view in stackView.arrangedSubviews {
                if view.frame.width > maxWidth {
                    maxWidth = view.frame.width
                }
                
                totalHeight += view.frame.height
            }
            
            return CGSize(width: maxWidth, height: totalHeight)
            
        } else { // horizontal
            var totalWidth: CGFloat = 0.0
            var maxHeight: CGFloat = 0.0
            for view in stackView.arrangedSubviews {
                if view.frame.height > maxHeight {
                    maxHeight = view.frame.height
                }
                
                totalWidth += view.frame.width
            }
            
            return CGSize(width: totalWidth, height: maxHeight)
        }
    }
}


extension DropdownComponent: Bindable {
    
    public typealias BindingType = Int
    
    public func observingValue() -> Int? {
        return self.selection
    }
    
    public func updateValue(_ value: Int) {
        self.selection = value
    }
}
