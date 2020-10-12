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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
