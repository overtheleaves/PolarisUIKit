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
    @IBOutlet var dropdown: DropdownComponent!
    
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
        
        let dropdownEvenAttr = StyleAttribute()
        dropdownEvenAttr.backgroundAttribute.color = Palette.lightBlue
        dropdownEvenAttr.textAttribute.color = Palette.lightGray
        dropdownEvenAttr.boxAttribute.padding = 10.0
        Palette.addAttribute("dropdownAttr.even", attribute: dropdownEvenAttr)
        
        let placeholder = LabelComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        placeholder.text = "select"
        placeholder.styleType = "dropdownAttr.even"
        self.dropdown.placeholderView = placeholder
        self.dropdown.direction = .vertical
        
        let menu1 = LabelComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        menu1.text = "menu1"
        menu1.styleType = "blueAttr"
        
        let menu2 = LabelComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        menu2.text = "menu2"
        menu2.styleType = "dropdownAttr.even"
        
        let menu3 = LabelComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        menu3.text = "menu3"
        menu3.styleType = "blueAttr"
        
        let menu4 = LabelComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        menu4.text = "menu4"
        menu4.styleType = "dropdownAttr.even"
        
        self.dropdown.addMenuViews(self.stackView, menuContentViews: [menu1, menu2, menu3, menu4])
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

