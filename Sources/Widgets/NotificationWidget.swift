//
//  NotificationComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 07/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit
import Foundation

public class NotificationWidget {
    
    var headerLabel: UILabel? = nil
    var contentLabel: UILabel
    
    let view: UIView
    let headerContentGap: CGFloat = 10.0
    let animationDuration: TimeInterval = 0.3
    
    public init(header: String?, content: String, attribute: StyleAttribute?) {
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var headerHeight: CGFloat = 0.0
        
        if header != nil {
            headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            headerLabel!.text = header
            headerLabel!.sizeToFit()
            headerHeight = headerLabel!.frame.height
            view.addSubview(headerLabel!)
        }
        
        contentLabel = UILabel(frame: CGRect(x: 0, y: headerHeight, width: 0, height: 0))
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        view.addSubview(contentLabel)
        contentLabel.sizeToFit()
        
        /// attribute
        if let attr = attribute {
            
            var totalHeight: CGFloat = 0.0
            
            /// header setting
            if let h = headerLabel {
                h.frame = CGRect(x: attr.boxAttribute.paddingLeft,
                                 y: attr.boxAttribute.paddingTop,
                                 width: UIScreen.main.bounds.width
                                    - attr.boxAttribute.paddingLeft
                                    - attr.boxAttribute.paddingRight,
                                 height: h.frame.height)
                
                h.textColor = attr.textAttribute.color
                totalHeight += h.frame.height
            }
            
            /// content setting
            contentLabel.frame = CGRect(x: attr.boxAttribute.paddingLeft,
                                        y: headerHeight + headerContentGap,
                                        width: UIScreen.main.bounds.width
                                            - attr.boxAttribute.paddingLeft
                                            - attr.boxAttribute.paddingRight,
                                        height: contentLabel.frame.height)
            contentLabel.textColor = attr.textAttribute.color
            contentLabel.sizeToFit()
            totalHeight += contentLabel.frame.height
            
            /// background view setting
            view.frame = CGRect(x: attr.boxAttribute.marginLeft,
                                y: attr.boxAttribute.marginTop,
                                width: UIScreen.main.bounds.width
                                    - attr.boxAttribute.marginLeft
                                    - attr.boxAttribute.marginRight,
                                height: totalHeight     // header height + content height
                                    + attr.boxAttribute.paddingTop
                                    + attr.boxAttribute.paddingBottom)
            
            view.backgroundColor = attr.backgroundAttribute.color
            view.layer.cornerRadius = attr.boxAttribute.borderRadius
        }
    }
    
    public func show(_ target: UIViewController, period time: NotificationPeriodTime, direction: NotificationShowDirection? = .FromTop) {
        
        let visibleFrame = view.frame
        var hiddenFrame: CGRect? = nil
        
        target.view.addSubview(view)
        
        // set animation hidden frame (outside of main screen)
        if let direction = direction {
            switch direction {
            case .FromTop:
                hiddenFrame = CGRect(origin: CGPoint(x: visibleFrame.origin.x,
                                                     y: -visibleFrame.height),
                                     size: visibleFrame.size)
            case .FromBottom:
                hiddenFrame = CGRect(origin: CGPoint(x: visibleFrame.origin.x,
                                                     y: UIScreen.main.bounds.height),
                                     size: visibleFrame.size)
            case .FromLeft:
                hiddenFrame = CGRect(origin: CGPoint(x: -visibleFrame.width,
                                                     y: visibleFrame.origin.y),
                                     size: visibleFrame.size)
            case .FromRight:
                hiddenFrame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.width,
                                                     y: visibleFrame.origin.y),
                                     size: visibleFrame.size)
            }
        }
        
        // 1. hide notification
        self.view.frame = hiddenFrame!
        
        // 2. show notification
        UIView.animate(withDuration: animationDuration) {
            self.view.frame = visibleFrame
        }
        
        // 3. hide notification after period time
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(time.rawValue), execute: {
            
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.view.frame = hiddenFrame!
            }, completion: { (success) in
                self.view.removeFromSuperview()
            })
        })
    }
}

public enum NotificationPeriodTime: Int {
    case LONG = 3000
    case SHORT = 1000
}

public enum NotificationShowDirection {
    case FromTop
    case FromBottom
    case FromLeft
    case FromRight
}
