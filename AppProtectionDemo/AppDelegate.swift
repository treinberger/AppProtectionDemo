//
//  AppDelegate.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 15.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appStatusManager: AppStatusManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.appStatusManager = AppStatusManager(self.window!)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        appStatusManager?.applicationWillResignActiveHandler()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        appStatusManager?.applicationDidEnterBackgroundHandler()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        appStatusManager?.applicationDidBecomeActiveHandler()
    }

}

