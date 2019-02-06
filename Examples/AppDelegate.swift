//
//  AppDelegate.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 02/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // default
        Palette.defaultFont = UIFont(name: "Avenir-Light", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // mylabel
        let attr = StyleAttribute()
        attr.backgroundAttribute.color = UIColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1)
        attr.textAttribute.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        attr.boxAttribute.padding = CGFloat(10.0)
        attr.boxAttribute.borderRadius = 5.0
        Palette.addAttribute("mylabel", attribute: attr)
        
        // myTextviewAttr
        let myTextviewAttr = StyleAttribute()
        myTextviewAttr.textAttribute.color = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        myTextviewAttr.boxAttribute.padding = 10.0
        myTextviewAttr.boxAttribute.borderRadius = 10.0
        myTextviewAttr.boxAttribute.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        myTextviewAttr.boxAttribute.borderWidth = 2.0
        Palette.addAttribute("myTextviewAttr", attribute: myTextviewAttr)
        
        // myTextfieldAttr
        let myTextfieldAttr = StyleAttribute()
        myTextfieldAttr.textAttribute.color = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        myTextfieldAttr.boxAttribute.padding = 10.0
        
        myTextfieldAttr.boxAttribute.shadowOpacity = 0.3
        myTextfieldAttr.boxAttribute.shadowRadius = 5
        myTextfieldAttr.boxAttribute.shadowOffset = CGSize(width: -1, height: 1)
        Palette.addAttribute("myTextfieldAttr", attribute: myTextfieldAttr)
        
        let myViewAttr = StyleAttribute()
        myViewAttr.boxAttribute.shadowOpacity = 0.3
        myViewAttr.boxAttribute.shadowRadius = 5
        myViewAttr.boxAttribute.shadowOffset = CGSize(width: -1, height: 1)
        Palette.addAttribute("myViewAttr", attribute: myViewAttr)
        
        let myCheckBtnAttrNormal = StyleAttribute()
        myCheckBtnAttrNormal.textAttribute.color = UIColor.white
        myCheckBtnAttrNormal.fontAttribute.font = Palette.defaultFont
        myCheckBtnAttrNormal.backgroundAttribute.color = UIColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1)
        myCheckBtnAttrNormal.boxAttribute.borderRadius = 5.0
        myCheckBtnAttrNormal.boxAttribute.padding = 10.0
        
        let myCheckBtnAttrSelected = StyleAttribute()
        myCheckBtnAttrSelected.textAttribute.color = UIColor.darkGray
        myCheckBtnAttrSelected.imageAttribute = ImageAttribute(image: (UIImage(named: "check")?.withRenderingMode(.alwaysOriginal))!)
        
        Palette.addAttribute("myCheckBtnAttr", attribute: myCheckBtnAttrNormal)
        Palette.addAttribute("myCheckBtnAttr", attribute: myCheckBtnAttrSelected, linkState: .pressed)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

