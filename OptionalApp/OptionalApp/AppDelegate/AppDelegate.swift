//
//  AppDelegate.swift
//  OptionalApp
//
//  Created by 佐藤優輝 on H30/04/25.
//  Copyright © 平成30年 佐藤優輝. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let specifiedPrefix: String = "Yusa"
        let optString: String? = "Yusayusa5678"
        if let result = optString?.hasPrefix(specifiedPrefix), result {
            print("結果は\(result)！\n\(specifiedPrefix)で始まる文字列だー(ﾟ∀ﾟ)！")
        } else {
            print("指定文字で始まらない or nil (´・ω・｀)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

