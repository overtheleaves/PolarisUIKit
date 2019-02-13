//
//  DropdownComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 13/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class DropdownComponent: UIButton {
    
    public typealias MenuSelectedHandler = (Int) -> Void
    
    public enum Direction {
        case vertical
        case horizontal
    }
    
    private var dropdownMenuContentView: UIStackView = UIStackView()
    public var direction: DropdownComponent.Direction! = .vertical
    //    public var dropdownMenuInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //    public var dropdownMenuOrigin: CGPoint = CGPoint(x: 0, y: 0) {
    //        didSet {
    //            dropdownMenuContentView.frame.origin = dropdownMenuOrigin
    //        }
    //    }
    public var menuSelectedHandler: MenuSelectedHandler?
    
    private var menuViews: [UIButton] = []
    private var target: UIView?
    private let widgetAnimator: WidgetAnimator = DefaultWidgetAnimator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        self.dropdownMenuContentView.axis = .vertical
        self.dropdownMenuContentView.distribution  = .fill
        self.dropdownMenuContentView.translatesAutoresizingMaskIntoConstraints = false
        self.dropdownMenuContentView.backgroundColor = Palette.darkGray
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // touch event
        self.addTarget(self, action: #selector(toggleSelected(_:)), for: .touchUpInside)
    }
    
    public func addMenuViews(_ target: UIView, menus: [UIButton]) {
        self.menuViews = menus
        self.target = target
        drawDropdownMenu()
    }
    
    func drawDropdownMenu() {
        // remove all views
        for view in self.dropdownMenuContentView.subviews {
            view.removeFromSuperview()
        }
        
        for menu in self.menuViews {
            // intrinsic content size
            menu.translatesAutoresizingMaskIntoConstraints = false
            menu.widthAnchor.constraint(equalToConstant: menu.frame.width).isActive = true
            menu.heightAnchor.constraint(equalToConstant: menu.frame.height).isActive = true
            
            self.dropdownMenuContentView.addArrangedSubview(menu)
            menu.addTarget(self, action: #selector(menuSelected(_:)), for: .touchUpInside)
        }
        
        self.dropdownMenuContentView.sizeToFit()
    }
    
    @objc func menuSelected(_ sender: UIButton) {
        var i = -1
        
        for index in 0..<self.menuViews.count {
            let menu = self.menuViews[index]
            if menu === sender {
                i = index
                break
            }
        }
        
        if let handler = self.menuSelectedHandler {
            handler(i)
        }
    }
    
    @objc func toggleSelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            show()
        } else {
            hide()
        }
    }
    
    func show() {
        if let target = self.target {
            let toggleViewFrame = self.frame
            
            target.addSubview(self.dropdownMenuContentView)
            
            let targetWidth = target.frame.width
            let targetHeight = target.frame.height
            let toggleViewX = toggleViewFrame.origin.x    // x of toggle view
            let toggleViewY = toggleViewFrame.origin.y    // y of toggle view
            let toggleViewHeight = self.frame.height
            let contentViewSize = stackViewSize(self.dropdownMenuContentView)
            
            // 1. check width and add leading or trailing anchor
            if toggleViewX + contentViewSize.width > targetWidth {
                // dropdownMenuContentView will be exceeded screen width.
                // use trailingAnchor
                self.dropdownMenuContentView.trailingAnchor
                    .constraint(equalTo: self.trailingAnchor,
                                constant: 0)
                    .isActive = true
            } else {
                // not exceed, use leadingAnchor
                self.dropdownMenuContentView.leadingAnchor
                    .constraint(equalTo: self.leadingAnchor,
                                constant: 0)
                    .isActive = true
            }
            
            // 2. check height and add top or bottom anchor
            if toggleViewY + toggleViewHeight + contentViewSize.height > targetHeight {
                // dropdownMenuContentView will be exceeded screen height
                // use bottonAnchor
                self.dropdownMenuContentView.bottomAnchor
                    .constraint(equalTo: self.topAnchor,
                                constant: 0)
                    .isActive = true
            } else {
                // not exceed, use topAnchor
                self.dropdownMenuContentView.topAnchor
                    .constraint(equalTo: self.bottomAnchor,
                                constant: 0)
                    .isActive = true
            }
            
            self.dropdownMenuContentView.layoutIfNeeded()
            
            widgetAnimator.show(self.dropdownMenuContentView,
                                showFrom: .FadeInScale, completion: nil)
        }
    }
    
    func hide() {
        self.dropdownMenuContentView.removeFromSuperview()
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
