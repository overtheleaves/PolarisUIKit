//
//  UIImageView+Advanced.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 15/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit 

extension UIImageView {
    func maskImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
