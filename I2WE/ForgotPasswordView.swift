//
//  ForgotPasswordView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var user: UserViewModel = UserViewModel(email: "", password: "", firstName: "", lastName: "", age: -1)
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var errString: String?
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter email address", text: $user.email).autocapitalization(.none).keyboardType(.emailAddress)
                    .foregroundColor(.black)
                    .font(.caption)
                    .border(Color.black, width: 1.5)
                Button(action: {
                    FBAuth.resetPassword(email: self.user.email) { result in
                        switch result {
                        case .failure(let error):
                            self.errString = error.localizedDescription
                        case .success ( _):
                            break
                        }
                        self.showAlert = true
                    }
                }) {
                    Text("Reset")
                        .padding(.vertical, 10)
                        .frame(width: 200)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(20)
                        .opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
                }
                .disabled(!user.isEmailValid(_email: user.email))
                Spacer()
            }
                .frame(width: 300)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"),
                      message: Text(self.errString ?? "Success! Check your email for a passwird reset link."), dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                      })
            }
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
