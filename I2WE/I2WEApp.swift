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
        // TODO:
        // Add profile, search, inbox, matches
        // Fix age on signup
        // Fix name, email, age updates
        // Add completion handlers for FBAuth.updateUser and FBAuth.getUser, add error checking
        // Organize files
        // Other bug fixes
        
        let userInfo = UserInfo()
        
        WindowGroup {
            ContentView().environmentObject(userInfo)
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
