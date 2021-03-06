//
//  PXSwiftAppDelegate.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
                
        let controller: ViewController = ViewController()
        let navController: UINavigationController = UINavigationController(rootViewController: controller)
        
        navController.navigationBar.barTintColor = UIColor.orangeColor()
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        window?.rootViewController = navController
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
}
