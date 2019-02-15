//
//  WidgetAnimator.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 09/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public protocol WidgetAnimator {
    typealias CompleteHandler = (Bool) -> Void
    func show(_ target: UIView, showFrom: Widget.ShowDirection?, completion: CompleteHandler?)
    func showAndHideAfter(after: TimeInterval, target: UIView, originFrame: CGRect?,
                          showFrom: Widget.ShowDirection?, hideTo: Widget.HideDirection?,
                          completion: CompleteHandler?)
    func hide(_ target: UIView, hideTo: Widget.HideDirection?, completion: CompleteHandler?)
}

class DefaultWidgetAnimator: WidgetAnimator {
    
    private let animateDuration = 0.4
    
    func show(_ target: UIView, showFrom: Widget.ShowDirection? = .FromTop, completion: CompleteHandler?) {
        
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
            case .FadeIn:
                target.isHidden = true
                
            case .FadeInScale:
                target.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
        
        // 1. set target hiddenframe
        if let hiddenFrame = hiddenFrame {
            target.frame = hiddenFrame
        }
        
        // 2. run show animation
        UIView.animate(withDuration: animateDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        if showFrom == .FadeIn {
                            target.isHidden = false
                        } else if showFrom == .FadeInScale {
                            target.transform = CGAffineTransform.identity
                        } else {
                            target.frame = originalFrame
                        }
        }, completion: completion)
        
    }
    
    func showAndHideAfter(after: TimeInterval, target: UIView, originFrame: CGRect?,
                          showFrom: Widget.ShowDirection? = .FromTop, hideTo: Widget.HideDirection? = .ToTop,
                          completion: CompleteHandler?) {
        
        show(target, showFrom: showFrom, completion: { (success) in
            // hide after
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(after)), execute: {
                self.hide(target, hideTo: hideTo, completion: completion)
            })
        })
    }
    
    func hide(_ target: UIView, hideTo: Widget.HideDirection? = .ToTop, completion: CompleteHandler?) {
        
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
            case .FadeOut:
                target.isHidden = false
                
            default: break
            }
        }
        
        UIView.animate(withDuration: animateDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        if hideTo == .FadeOut {
                            target.isHidden = true
                        } else if hideTo == .FadeOutScale {
                            target.transform = CGAffineTransform(scaleX: 0, y: 0)
                        } else {
                            if let hiddenFrame = hiddenFrame {
                                target.frame = hiddenFrame
                            }
                        }
        }, completion: completion)
    }
}
