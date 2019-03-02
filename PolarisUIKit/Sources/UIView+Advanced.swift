//
//  UIVIew+Advanced.swift
//  everythings
//
//  Created by overtheleaves on 02/03/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

extension UIView {
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
