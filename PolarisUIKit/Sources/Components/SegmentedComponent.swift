//
//  SwitcherComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 10/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class SegmentedComponent: UISegmentedControl {
    
    private var sortedViews: [UIView]!
    private var currentSegmentIndex: Int = 0

    @IBInspectable public var styleType: String {
        get {
            return self.styleAttr.type
        }
        set {
            if self.styleAttr.type != newValue {
                if let attr = Palette.getAttribute(name: newValue) {
                    self.styleAttr.type = newValue
                    self.attribute = attr
                }
            }
        }
    }
    
    public var attribute: StyleAttribute? {
        get { return styleAttr.attribute }
        set {
            styleAttr.attribute = newValue
            decorate()
        }
    }
    
    func decorate() {

        sortedViews = self.subviews.sorted(by:{$0.frame.origin.x < $1.frame.origin.x})

        // normal state
        if let attribute = Palette.getAttribute(name: self.styleType, linkState: .normal) {
            Palette.decorateLayer(self.layer, view: self, attribute: attribute)
            
            self.tintColor = UIColor.clear
            self.layer.masksToBounds = true
            self.currentSegmentIndex = self.selectedSegmentIndex
            
            var dict: [NSAttributedString.Key:Any] = [:]
            dict[NSAttributedString.Key.foregroundColor] = attribute.textAttribute.color
            setTitleTextAttributes(dict, for: .normal)
        }
        
        if let pressedAttribute = Palette.getAttribute(name: self.styleType, linkState: .pressed) {
            var dict: [NSAttributedString.Key:Any] = [:]
            dict[NSAttributedString.Key.foregroundColor] = pressedAttribute.textAttribute.color
            setTitleTextAttributes(dict, for: .selected)
        }
        
        valueChanged()
        self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged() {
        if let attribute = Palette.getAttribute(name: self.styleType, linkState: .normal) {
            sortedViews[currentSegmentIndex].backgroundColor = attribute.backgroundAttribute.color
        }
        
        if let pressedAttribute = Palette.getAttribute(name: self.styleType, linkState: .pressed) {
            sortedViews[self.selectedSegmentIndex].backgroundColor = pressedAttribute.backgroundAttribute.color
        }
        
        currentSegmentIndex = self.selectedSegmentIndex
    }
}
