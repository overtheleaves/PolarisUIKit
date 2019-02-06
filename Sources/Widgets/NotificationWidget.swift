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
            
            contentLabel.frame = CGRect(x: attr.boxAttribute.paddingLeft,
                                        y: headerHeight + headerContentGap,
                                        width: UIScreen.main.bounds.width
                                            - attr.boxAttribute.paddingLeft
                                            - attr.boxAttribute.paddingRight,
                                        height: contentLabel.frame.height)
            contentLabel.textColor = attr.textAttribute.color
            contentLabel.sizeToFit()
            totalHeight += contentLabel.frame.height
            
            view.frame = CGRect(x: attr.boxAttribute.marginLeft,
                                y: attr.boxAttribute.marginTop,
                                width: UIScreen.main.bounds.width
                                    - attr.boxAttribute.marginLeft
                                    - attr.boxAttribute.marginRight,
                                height: totalHeight
                                    + attr.boxAttribute.paddingTop
                                    + attr.boxAttribute.paddingBottom)
            
            view.backgroundColor = attr.backgroundAttribute.color
            view.layer.cornerRadius = attr.boxAttribute.borderRadius
        }
    }
    
    public func show(_ target: UIViewController, time: NotificationShowTime) {
        
        self.view.removeFromSuperview()
        
        let originalFrame = view.frame
        target.view.addSubview(view)
        view.frame.origin.y = -view.frame.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame = originalFrame
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(time.rawValue), execute: {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y = -originalFrame.height
            }, completion: { (success) in
                self.view.removeFromSuperview()
            })
        })
    }
}

public enum NotificationShowTime: Int {
    case LONG = 3000
    case SHORT = 1000
}

public enum NotificationShowDirection {
    case FromTop
    case FromBottom
    case FromLeft
    case FromRight
}
