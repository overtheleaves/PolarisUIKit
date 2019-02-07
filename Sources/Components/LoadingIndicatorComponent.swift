//
//  LoadingIndicatorComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 07/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class LoadingIndicatorComponent: UIView {
    
    public var colors: [UIColor] = [Palette.green, Palette.red, Palette.blue, Palette.orange, Palette.violet]
    public var color: UIColor? = nil
    public var stepPeriod = 0.35
    
    private var running = false
    private var roundedStep: [UIRectCorner] = [UIRectCorner(), .bottomRight, .bottomLeft, .topLeft, .topRight]
    
    enum Direction {
        case forward
        case backward
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.layer.cornerRadius = 3.0
    }
    
    public func start() {
        let totalStep = colors.count
        let rotateDegree: CGFloat = CGFloat(360 / (totalStep - 1))    // degree
        let step = 0
        
        self.running = true
        self.backgroundColor = colors[step]
        
        run(rotateDegree: rotateDegree, step: step + 1, totalStep: totalStep,
            direction: .forward,   // forward step
            byRoundingCorners: [self.roundedStep[step + 1]])
    }
    
    private func run(rotateDegree: CGFloat, step: Int, totalStep: Int, direction: Direction, byRoundingCorners: UIRectCorner) {
        
        if !running {
            return
        }
        
        // user defined color scheme first
        var color = self.color ?? self.colors[step]
        
        if direction == .backward && self.color == nil {
            color = self.colors[totalStep - step - 1]
        }
        
        UIView.animate(withDuration: stepPeriod,
                       delay: 0,
                       options: .curveEaseOut,
            animations: {
            self.backgroundColor = color
                self.roundCorners(cornerRadius: Double(self.frame.height / 2), byRoundingCorners: byRoundingCorners)
            self.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi / 180 * rotateDegree))
            
        }) { (success) in
            
            var nextStep = step
            var nextDirection: Direction = direction
            var nextByRoundingCorners: UIRectCorner = UIRectCorner()
            nextByRoundingCorners.insert(byRoundingCorners)
            
            switch direction {
            case .forward:
                nextStep = step + 1
                if nextStep >= totalStep {
                    nextStep = step - 1
                    nextDirection = .backward
                    nextByRoundingCorners.remove(self.roundedStep[1])
                } else {
                    nextByRoundingCorners.insert(self.roundedStep[nextStep])
                }
                
            case .backward:
                nextStep = step - 1
                if nextStep < 0 {
                    nextStep = 1
                    nextDirection = .forward
                    nextByRoundingCorners.insert(self.roundedStep[1])
                } else {
                    nextByRoundingCorners.remove(self.roundedStep[totalStep - nextStep - 1])
                }
            }
            
            self.run(rotateDegree: rotateDegree + CGFloat(360 / (totalStep - 1)),
                     step: nextStep,
                     totalStep: totalStep,
                     direction: nextDirection,
                     byRoundingCorners: nextByRoundingCorners)
        }
    }
    
    public func stop() {
        self.running = false
    }
    
    func roundCorners(cornerRadius: Double, byRoundingCorners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: byRoundingCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
