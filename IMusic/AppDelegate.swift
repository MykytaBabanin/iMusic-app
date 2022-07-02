//
//  AppDelegate.swift
//  IMusic
//
//  Created by Mykyta Babanin on 11/03/2022.
//

import UIKit
import UserNotifications
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let notificationCenter: UNUserNotificationCenter = .current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print(error)
        }
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "YqZ6FneMh6wFySgIMdM22bZr4trVmttGC0OabYd1"
            $0.clientKey = "gLSGQprHzkZjojEfNnBxYh9PKGHEXfHmGreZAuZg"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

