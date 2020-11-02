//
//  TabBar.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI

struct TabBar: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView {
            SwipeView().tabItem {
                Image(systemName: "person.3.fill")
            }
            MatchesView().tabItem {
                Image(systemName: "person.2.fill")
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
        TabBar()
    }
}
