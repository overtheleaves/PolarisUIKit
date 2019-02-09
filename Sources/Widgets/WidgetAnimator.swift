//
//  WidgetAnimator.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 09/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class WidgetAnimator {
    
    private static let animateDuration = 0.4
    public typealias CompleteHandler = (Bool) -> Void
    
    
    static func show(_ target: UIView, showFrom: Widget.ShowDirection? = .FromTop, completion: CompleteHandler?) {
        
        let originalFrame = target.frame
        var hiddenFrame: CGRect?
        
        if let showFrom = showFrom {
            switch showFrom {
            case .FromTop:
                hiddenFrame = CGRect(origin: CGPoint(x: originalFrame.origin.x,
                                                     y: -originalFrame.height),
                                     size: originalFrame.size)
            case .FromBottom:
                hiddenFrame = CGRect(origin: CGPoint(x: originalFrame.origin.x,
                                                     y: UIScreen.main.bounds.height),
                                     size: originalFrame.size)
            case .FromLeft:
                hiddenFrame = CGRect(origin: CGPoint(x: -originalFrame.width,
                                                     y: originalFrame.origin.y),
                                     size: originalFrame.size)
            case .FromRight:
                hiddenFrame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.width,
                                                     y: originalFrame.origin.y),
                                     size: originalFrame.size)
            }
        }
        
        // 1. set target hiddenframe
        target.frame = hiddenFrame!

        // 2. run show animation
        UIView.animate(withDuration: WidgetAnimator.animateDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        target.frame = originalFrame
        }, completion: completion)
        
    }
    
    static func showAndHideAfter(after: TimeInterval, target: UIView,
                                 showFrom: Widget.ShowDirection? = .FromTop, hideTo: Widget.HideDirection? = .ToTop,
                                 completion: CompleteHandler?) {
        
        show(target, showFrom: showFrom, completion: { (success) in
            // hide after
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(after)), execute: {
                hide(target, hideTo: hideTo, completion: completion)
            })
        })
    }
    
    static func hide(_ target: UIView, hideTo: Widget.HideDirection? = .ToTop, completion: CompleteHandler?) {
        
        let originalFrame = target.frame
        var hiddenFrame: CGRect?
        
        if let hideTo = hideTo {
            switch hideTo {
            case .ToTop:
                hiddenFrame = CGRect(origin: CGPoint(x: originalFrame.origin.x,
                                                     y: -originalFrame.height),
                                     size: originalFrame.size)
            case .ToBottom:
                hiddenFrame = CGRect(origin: CGPoint(x: originalFrame.origin.x,
                                                     y: UIScreen.main.bounds.height),
                                     size: originalFrame.size)
            case .ToLeft:
                hiddenFrame = CGRect(origin: CGPoint(x: -originalFrame.width,
                                                     y: originalFrame.origin.y),
                                     size: originalFrame.size)
            case .ToRight:
                hiddenFrame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.width,
                                                     y: originalFrame.origin.y),
                                     size: originalFrame.size)
            }
        }
        
        UIView.animate(withDuration: animateDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                      target.frame = hiddenFrame!
        }, completion: completion)
    }
}
