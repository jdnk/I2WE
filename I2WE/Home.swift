//
//  Home.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI
import Firebase

struct Home: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView {
            SearchView().tabItem {
                Image(systemName: "person.3.fill")
            }
            ChatView().tabItem {
                Image(systemName: "paperplane.fill")
            }
            AccountView().tabItem {
                Image(systemName: "person.circle.fill")
            }
        }
        .accentColor(.black)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
