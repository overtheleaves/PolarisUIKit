//
//  ButtonGroupComponent.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 04/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

public class ButtonGroupComponent: UIView {

    var buttons: [ButtonComponent] = []
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        // add button automatically
        for view in subviews {
            if let button = view as? ButtonComponent {
                addButton(button)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // add button automatically
        for view in subviews {
            if let button = view as? ButtonComponent {
                addButton(button)
            }
        }
    }
    
    func addButton(_ button: ButtonComponent) {
        self.buttons.append(button)
        button.buttonGroup = self
    }
    
    func addButton(title: String, roleType: ButtonRoleType, attributeName: String?) {
        let button = ButtonComponent()
        button.buttonRoleType = roleType
        
        if let name = attributeName {
            button.injectAttribute(attributeName: name)
            button.decorate()
        }
        
        addButton(button)
    }
    
    func notifyButtonSelectedChange(_ sender: ButtonComponent) {
    
        let selected = sender.isSelected
        
        if selected {   // clear other radio's selected state
            for button in buttons {
                if button != sender && button.buttonRoleType == .radio {
                    button.isSelected = false
                }
            }
        }
    }
}
