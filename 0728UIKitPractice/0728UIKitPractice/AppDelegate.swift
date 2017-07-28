//
//  AppDelegate.swift
//  0728UIKitPractice
//
//  Created by 楊采庭 on 2017/7/28.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()

        return true
    }
}
