//
//  AccountView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct AccountView: View {
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.presentationMode) var presentationMode
    @State var showError = false
    @State var errorString = ""
    
    var good: Int = FBAuth.getCurUser()

    var body: some View {
        
        NavigationView {
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        Text("Yo")
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
