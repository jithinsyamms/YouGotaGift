//
//  AppDelegate.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var isRunningUITest = false
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if ProcessInfo.processInfo.arguments.contains("YouGotaGift-UITest") {
            AppDelegate.isRunningUITest = true
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
