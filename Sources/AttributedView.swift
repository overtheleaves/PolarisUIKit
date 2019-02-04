//
//  AttributedView.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class AttributedView: UIView {

    @IBInspectable public var type: String? {
        get {
            return self.styleAttr.type
        }
        set {
            if self.styleAttr.type != newValue {
                self.styleAttr.type = newValue
                initialize()
            }
        }
    }
    
    func initialize() {
        if let val = self.styleAttr.type, let attribute = Palette.getAttribute(id: val) {
            
            self.styleAttr.attribute = attribute
            
            /// Box Attribute
            ///
            /// box layer
            let decorateLayer = CALayer()
            Palette.decorateLayer(decorateLayer, view: self, attribute: attribute)
            
            decorateLayer.frame = getAttributedPaddingRect(original: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.height))
                      
            self.layer.addSublayer(decorateLayer)
        }
    }
    
}
