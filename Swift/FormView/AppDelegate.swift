//
//  AppDelegate.swift
//  FormView
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let strs: [(String, String)] = [
            ("Abkhazia",  "+99544"),
            ("Afghanistan",  "+93"),
            ("Åland Islands",  "+35818"),
            ("Albania",  "+355"),
            ("Algeria",  "+213"),
            ("American Samoa",  "+1684"),
            ("Andorra",  "+376"),
            ("Angola",  "+244"),
            ("Anguilla",  "+1264"),
            ("Antigua and Barbuda",  "+1268"),
            ("Argentina",  "+54"),
            ("Armenia",  "+374"),
            ("Aruba",  "+297"),
            ("Ascension",  "+247"),
            ("Australia",  "+61"),
            ("Australian External Territories", "+672"),
            ("Austria",  "+43"),
            ("Azerbaijan",  "+994"),
        ]
        
        strs.forEach(convert)

        return true
    }
    
    func convert(str: (String, String)) {
        print("<dict>")
        print("    <key>dial_code</key>")
        print("    <string>\(str.1)</string>")
        print("    <key>name</key>")
        print("    <string>\(str.0)</string>")
        print("    <key>content</key>")
        print("    <string>\(str.0)\(str.1)</string>")
        print("</dict>")
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

