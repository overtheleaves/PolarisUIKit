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
        
        // default
        Palette.defaultFont = UIFont(name: "Avenir-Light", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // mylabel
        let attr = StyleAttribute()
        attr.backgroundAttribute.color = Palette.lightDark
        attr.textAttribute.color = Palette.lightGray
        attr.boxAttribute.padding = CGFloat(10.0)
        attr.boxAttribute.borderRadius = 5.0
        Palette.addAttribute("mylabel", attribute: attr)
        
        // myTextviewAttr
        let myTextviewAttr = StyleAttribute()
        myTextviewAttr.textAttribute.color = Palette.text
        myTextviewAttr.boxAttribute.padding = 10.0
        myTextviewAttr.boxAttribute.borderRadius = 10.0
        myTextviewAttr.boxAttribute.borderColor = Palette.gray
        myTextviewAttr.boxAttribute.borderWidth = 1.2
        Palette.addAttribute("myTextviewAttr", attribute: myTextviewAttr)
        
        // myTextfieldAttr
        let myTextfieldAttr = StyleAttribute()
        myTextfieldAttr.textAttribute.color = Palette.text
        myTextfieldAttr.boxAttribute.borderColor = Palette.gray
        myTextfieldAttr.boxAttribute.borderWidth = 1.2
        myTextfieldAttr.boxAttribute.borderRadiusWithHeightRatio = 0.5
        Palette.addAttribute("myTextfieldAttr", attribute: myTextfieldAttr)
        
        let myViewAttr = StyleAttribute()
        myViewAttr.boxAttribute.shadowOpacity = 0.3
        myViewAttr.boxAttribute.shadowRadius = 5
        myViewAttr.boxAttribute.shadowOffset = CGSize(width: -1, height: 1)
        Palette.addAttribute("myViewAttr", attribute: myViewAttr)
        
        // myCheckBtnAttr
        let myCheckBtnAttrNormal = StyleAttribute()
        myCheckBtnAttrNormal.textAttribute.color = UIColor.white
        myCheckBtnAttrNormal.fontAttribute.font = Palette.defaultFont
        myCheckBtnAttrNormal.backgroundAttribute.color = Palette.green
        myCheckBtnAttrNormal.boxAttribute.borderRadius = 5.0
        myCheckBtnAttrNormal.boxAttribute.padding = 10.0
        
        let myCheckBtnAttrSelected = StyleAttribute()
        myCheckBtnAttrSelected.textAttribute.color = UIColor.white
        myCheckBtnAttrSelected.imageAttribute = ImageAttribute(image: (UIImage(named: "check")?.withRenderingMode(.alwaysOriginal))!)
        
        Palette.addAttribute("myCheckBtnAttr", attribute: myCheckBtnAttrNormal)
        Palette.addAttribute("myCheckBtnAttr", attribute: myCheckBtnAttrSelected, linkState: .pressed)
        
        // mysegment attr
        let mySegmentAttrNormal = StyleAttribute()
        mySegmentAttrNormal.boxAttribute.borderColor = Palette.darkGray
        mySegmentAttrNormal.boxAttribute.borderWidth = 1.0
        mySegmentAttrNormal.boxAttribute.borderRadiusWithHeightRatio = 0.5
        mySegmentAttrNormal.backgroundAttribute.color = UIColor.clear
        mySegmentAttrNormal.textAttribute.color = Palette.lightViolet
        
        let mySegmentAttrSelected = StyleAttribute()
        mySegmentAttrSelected.backgroundAttribute.color = Palette.violet
        mySegmentAttrSelected.textAttribute.color = UIColor.white
        
        Palette.addAttribute("mySegmentAttr", attribute: mySegmentAttrNormal)
        Palette.addAttribute("mySegmentAttr", attribute: mySegmentAttrSelected, linkState: .pressed)
        
        // color scheme attributes
        let commonBoxAttribute = BoxAttribute()
        commonBoxAttribute.borderRadius = 5.0
        commonBoxAttribute.padding = 10.0
        
        let commonTextAttribute = TextAttribute()
        commonTextAttribute.color = Palette.lightGray
        
        let lightGreenAttr = StyleAttribute()
        lightGreenAttr.backgroundAttribute.color = Palette.lightGreen
        lightGreenAttr.boxAttribute = commonBoxAttribute
        lightGreenAttr.textAttribute = commonTextAttribute
        
        let greenAttr = StyleAttribute()
        greenAttr.backgroundAttribute.color = Palette.green
        greenAttr.boxAttribute = commonBoxAttribute
        greenAttr.textAttribute = commonTextAttribute
        
        let darkGreenAttr = StyleAttribute()
        darkGreenAttr.backgroundAttribute.color = Palette.darkGreen
        darkGreenAttr.boxAttribute = commonBoxAttribute
        darkGreenAttr.textAttribute = commonTextAttribute
        
        let lightBlueAttr = StyleAttribute()
        lightBlueAttr.backgroundAttribute.color = Palette.lightBlue
        lightBlueAttr.boxAttribute = commonBoxAttribute
        lightBlueAttr.textAttribute = commonTextAttribute
        
        let blueAttr = StyleAttribute()
        blueAttr.backgroundAttribute.color = Palette.blue
        blueAttr.boxAttribute = commonBoxAttribute
        blueAttr.textAttribute = commonTextAttribute
        
        let darkBlueAttr = StyleAttribute()
        darkBlueAttr.backgroundAttribute.color = Palette.darkBlue
        darkBlueAttr.boxAttribute = commonBoxAttribute
        darkBlueAttr.textAttribute = commonTextAttribute
        
        let lightRedAttr = StyleAttribute()
        lightRedAttr.backgroundAttribute.color = Palette.lightRed
        lightRedAttr.boxAttribute = commonBoxAttribute
        lightRedAttr.textAttribute = commonTextAttribute
        
        let redAttr = StyleAttribute()
        redAttr.backgroundAttribute.color = Palette.red
        redAttr.boxAttribute = commonBoxAttribute
        redAttr.textAttribute = commonTextAttribute
        
        let darkRedAttr = StyleAttribute()
        darkRedAttr.backgroundAttribute.color = Palette.darkRed
        darkRedAttr.boxAttribute = commonBoxAttribute
        darkRedAttr.textAttribute = commonTextAttribute
        
        let lightOrangeAttr = StyleAttribute()
        lightOrangeAttr.backgroundAttribute.color = Palette.lightOrange
        lightOrangeAttr.boxAttribute = commonBoxAttribute
        lightOrangeAttr.textAttribute = commonTextAttribute
        
        let orangeAttr = StyleAttribute()
        orangeAttr.backgroundAttribute.color = Palette.orange
        orangeAttr.boxAttribute = commonBoxAttribute
        orangeAttr.textAttribute = commonTextAttribute
        
        let darkOrangeAttr = StyleAttribute()
        darkOrangeAttr.backgroundAttribute.color = Palette.darkOrange
        darkOrangeAttr.boxAttribute = commonBoxAttribute
        darkOrangeAttr.textAttribute = commonTextAttribute
        
        let lightVioletAttr = StyleAttribute()
        lightVioletAttr.backgroundAttribute.color = Palette.lightViolet
        lightVioletAttr.boxAttribute = commonBoxAttribute
        lightVioletAttr.textAttribute = commonTextAttribute
        
        let violetAttr = StyleAttribute()
        violetAttr.backgroundAttribute.color = Palette.violet
        violetAttr.boxAttribute = commonBoxAttribute
        violetAttr.textAttribute = commonTextAttribute
        
        let darkVioletAttr = StyleAttribute()
        darkVioletAttr.backgroundAttribute.color = Palette.darkViolet
        darkVioletAttr.boxAttribute = commonBoxAttribute
        darkVioletAttr.textAttribute = commonTextAttribute
        
        let lightDarkAttr = StyleAttribute()
        lightDarkAttr.backgroundAttribute.color = Palette.lightDark
        lightDarkAttr.boxAttribute = commonBoxAttribute
        lightDarkAttr.textAttribute = commonTextAttribute
        
        let darkAttr = StyleAttribute()
        darkAttr.backgroundAttribute.color = Palette.dark
        darkAttr.boxAttribute = commonBoxAttribute
        darkAttr.textAttribute = commonTextAttribute
        
        let veryDarkAttr = StyleAttribute()
        veryDarkAttr.backgroundAttribute.color = Palette.veryDark
        veryDarkAttr.boxAttribute = commonBoxAttribute
        veryDarkAttr.textAttribute = commonTextAttribute
        
        let lightGrayAttr = StyleAttribute()
        lightGrayAttr.backgroundAttribute.color = Palette.lightGray
        lightGrayAttr.boxAttribute = commonBoxAttribute
        lightGrayAttr.textAttribute = commonTextAttribute
        
        let grayAttr = StyleAttribute()
        grayAttr.backgroundAttribute.color = Palette.gray
        grayAttr.boxAttribute = commonBoxAttribute
        grayAttr.textAttribute = commonTextAttribute
        
        let darkGrayAttr = StyleAttribute()
        darkGrayAttr.backgroundAttribute.color = Palette.darkGray
        darkGrayAttr.boxAttribute = commonBoxAttribute
        darkGrayAttr.textAttribute = commonTextAttribute
        
        let textAttr = StyleAttribute()
        textAttr.backgroundAttribute.color = Palette.text
        textAttr.boxAttribute = commonBoxAttribute
        textAttr.textAttribute = commonTextAttribute
        
        Palette.addAttribute("lightGreenAttr", attribute: lightGreenAttr)
        Palette.addAttribute("greenAttr", attribute: greenAttr)
        Palette.addAttribute("darkGreenAttr", attribute: darkGreenAttr)
        
        Palette.addAttribute("lightBlueAttr", attribute: lightBlueAttr)
        Palette.addAttribute("blueAttr", attribute: blueAttr)
        Palette.addAttribute("darkBlueAttr", attribute: darkBlueAttr)

        Palette.addAttribute("lightRedAttr", attribute: lightRedAttr)
        Palette.addAttribute("redAttr", attribute: redAttr)
        Palette.addAttribute("darkRedAttr", attribute: darkRedAttr)
        
        Palette.addAttribute("lightOrangeAttr", attribute: lightOrangeAttr)
        Palette.addAttribute("orangeAttr", attribute: orangeAttr)
        Palette.addAttribute("darkOrangeAttr", attribute: darkOrangeAttr)
        
        Palette.addAttribute("lightVioletAttr", attribute: lightVioletAttr)
        Palette.addAttribute("violetAttr", attribute: violetAttr)
        Palette.addAttribute("darkVioletAttr", attribute: darkVioletAttr)
        
        Palette.addAttribute("lightDarkAttr", attribute: lightDarkAttr)
        Palette.addAttribute("darkAttr", attribute: darkAttr)
        Palette.addAttribute("veryDarkAttr", attribute: veryDarkAttr)
        
        Palette.addAttribute("lightGrayAttr", attribute: lightGrayAttr)
        Palette.addAttribute("grayAttr", attribute: grayAttr)
        Palette.addAttribute("darkGrayAttr", attribute: darkGrayAttr)
        
        Palette.addAttribute("textAttr", attribute: textAttr)
        
        /// add root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ViewController()
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()

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

