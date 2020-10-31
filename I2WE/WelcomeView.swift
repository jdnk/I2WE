//
//  WelcomeView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/19/20.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                Text("Sign in")
                    .foregroundColor(Color.black)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("Sign up")
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
