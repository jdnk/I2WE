//
//  SignInWithEmailView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SignInWithEmailView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel(email: "", password: "", firstName: "", lastName: "", age: -1)
    @Binding var showSheet: Bool
    @Binding var action:LoginView.Action?
    
    @State private var showAlert = false
    @State private var authError: EmailAuthError?
    var body: some View {
        VStack {
            TextField("Email Address",
                      text: self.$user.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .foregroundColor(.black)
                .font(.caption)
                .border(Color.black, width: 1.5)
            SecureField("Password", text: $user.password)
                .foregroundColor(.black)
                .font(.caption)
                .border(Color.black, width: 1.5)
            HStack {
                Spacer()
                Button(action: {
                    self.action = .resetPW
                    self.showSheet = true
                }) {
                    HStack(alignment: .center) {
                        Text("Forgot Password")
                            .cornerRadius(20)
                            .accentColor(.black)
                            .font(.caption)
                    }
                }
            }.padding(.bottom)
            VStack(spacing: 10) {
                Button(action: {
                    FBAuth.authenticate(withEmail: self.user.email,
                                        password: self.user.password) { result in
                                            switch result {
                                            case .failure(let error):
                                                self.authError = error
                                                self.showAlert = true
                                            case .success ( _):
                                                print("Signed in!")
                                            }
                    }
                }) {
                    Text("Login")
                        .padding(.vertical, 10)
                        .frame(width: 200)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(20)
                        .opacity(user.isLogInComplete ? 1 : 0.75)
                }.disabled(!user.isLogInComplete)
                Button(action: {
                    self.action = .signUp
                    self.showSheet = true
                }) {
                    Text("Sign Up")
                        .padding(.vertical, 10)
                        .frame(width: 200)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(20)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                    if self.authError == .incorrectPassword {
                        self.user.password = ""
                    } else {
                        self.user.password = ""
                        self.user.email = ""
                    }
                })
            }
        }
        .padding(.top, 100)
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
    }
}
