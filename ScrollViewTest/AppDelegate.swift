//
//  AppDelegate.swift
//  ScrollViewTest
//
//  Created by Marc Respass on 5/25/17.
//  Copyright © 2017 ILIOS Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainVC: OnboardEmail?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow()
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.mainVC = OnboardEmail()
        
        self.window?.rootViewController = self.mainVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
    


}

