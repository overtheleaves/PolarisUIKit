//
//  ViewController.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 02/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit
import PolarisUIKit

class ViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loadingIndicator: LoadingIndicatorComponent!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint( equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        
        self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        
        loadingIndicator.start()
    }
    
    @IBAction func showNotification(_ sender: Any) {
        let attr = StyleAttribute()
        attr.backgroundAttribute.color = Palette.red
        attr.textAttribute.color = Palette.lightGray
        attr.textAttribute.letterSpacing = 1.2
        attr.boxAttribute.padding = CGFloat(10.0)
        attr.boxAttribute.borderRadius = 5.0
        attr.boxAttribute.marginLeft = 10.0
        attr.boxAttribute.marginRight = 10.0
        attr.boxAttribute.marginTop = 30.0
        
        let notificationWidget = NotificationWidget(header: "Header!",
                                                    content: "This is your notification contents!\nYou successfully read this notification :)",
                                                    attribute: attr)
        notificationWidget.show(self, period: .LONG)
    }
    
    @IBAction func showPopup(_ sender: Any) {
        PopupWidget.show(self,
                         header: "Header!",
                         content: "This is your popup contents!\nYou successfully read this notification :)",
                         attribute: nil)
    }
}

