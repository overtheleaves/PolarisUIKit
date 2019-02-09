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
    
    public var widgetAnimator: WidgetAnimator = DefaultWidgetAnimator()
   
    private var headerLabel: UILabel? = nil
    private var contentLabel: UILabel
    
    private let view: UIView
    private let headerContentGap: CGFloat = 10.0
    private let animationDuration: TimeInterval = 0.3
    
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
                h.font = attr.fontAttribute.font.bold()
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
            contentLabel.font = attr.fontAttribute.font
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
    
    public func show(_ target: UIViewController, period time: PeriodTime,
                     showFrom: Widget.ShowDirection? = .FromTop, hideTo: Widget.HideDirection? = .ToTop) {
        
        target.view.addSubview(view)
        
        widgetAnimator.showAndHideAfter(after: TimeInterval(time.rawValue),
                                        target: self.view,
                                        showFrom: showFrom, hideTo: hideTo,
                                        completion: nil)
    }
    
    public enum PeriodTime: Int {
        case LONG = 3000
        case SHORT = 1000
    }
}
