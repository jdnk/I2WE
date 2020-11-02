//
//  I2WEApp.swift
//  I2WE
//
//  Created by Jaden Kim on 10/12/20.
//

import SwiftUI
import Firebase

@main
struct I2WEApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up Firebase...")
        FirebaseApp.configure()
        return true
    }
}
