//
//  AttributedView.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class ViewComponent: UIView {

    @IBInspectable public var styleType: String {
        get {
            return self.styleAttr.type
        }
        set {
            if self.styleAttr.type != newValue {
                self.styleAttr.type = newValue
                decorate()
            }
        }
    }
        
    func decorate() {
        if let attribute = Palette.getAttribute(name: self.styleAttr.type) {
            
            self.styleAttr.attribute = attribute
            
            /// Box Attribute
            ///
            /// box layer
//            let decorateLayer = CALayer()
//            Palette.decorateLayer(decorateLayer, view: self, attribute: attribute)
            
            Palette.decorateLayer(self.layer, view: self, attribute: attribute)
            self.layer.frame = getAttributedPaddingRect(original: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.height))
                      
//            self.layer.addSublayer(decorateLayer)
        }
    }
    
}
