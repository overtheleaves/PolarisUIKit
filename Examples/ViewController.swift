//
//  ViewController.swift
//  PolarisUIKit
//
//  Created by mirikim on 02/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showNotification(_ sender: Any) {
        
        let attr = StyleAttribute()
        attr.backgroundAttribute.color = UIColor.darkGray
        attr.textAttribute.color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        attr.textAttribute.letterSpacing = 1.2
        attr.fontAttribute.font =  UIFont(name: "Avenir-Light", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        attr.boxAttribute.padding = CGFloat(10.0)
        attr.boxAttribute.borderRadius = 5.0
        attr.boxAttribute.marginLeft = 10.0
        attr.boxAttribute.marginRight = 10.0
        attr.boxAttribute.marginTop = 30.0
        
        let notificationWidget = NotificationWidget(header: "Header!",
                                                    content: "This is your notification contents!\nYou successfully read this notification :)",
                                                    attribute: attr)
        notificationWidget.show(self, time: .LONG)
    }
}

