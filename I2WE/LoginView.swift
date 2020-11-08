//
//  LoginView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/7/20.
//

import SwiftUI

struct LoginView: View {
    enum Action {
        case signUp, resetPW
    }
    @State private var showSheet = false
    @State private var action: Action?
    var body: some View {
        SignInWithEmailView(showSheet: $showSheet, action: $action)
            .sheet(isPresented: $showSheet) {
                if (self.action == .resetPW) {
                    ForgotPasswordView()
                } else {
                    SignUpView()
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
