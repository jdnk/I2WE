//
//  SignUpView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel(email: "", password: "", firstName: "", lastName: "", age: 18)
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        TextField("First Name", text: self.$user.firstName).autocapitalization(.words)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.validFirstNameText.isEmpty {
                            Text(user.validFirstNameText).font(.caption).foregroundColor(.red)
                        }
                        TextField("Last Name", text: self.$user.lastName).autocapitalization(.words)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.validLastNameText.isEmpty {
                            Text(user.validLastNameText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Age", value: self.$user.age, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.validAgeText.isEmpty {
                            Text(user.validAgeText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Email Address", text: self.$user.email).autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.validEmailAddressText.isEmpty {
                            Text(user.validEmailAddressText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        SecureField("Password", text: self.$user.password)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.validPasswordText.isEmpty {
                            Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        SecureField("Confirm Password", text: self.$user.confirmPassword)
                            .foregroundColor(.black)
                            .font(.caption)
                            .border(Color.black, width: 1.5)
                        if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
                            Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                }.frame(width: 300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                VStack(spacing: 20 ) {
                    Button(action: {
                        FBAuth.createUser(withEmail: self.user.email,
                                          firstName: self.user.firstName,
                                          lastName: self.user.lastName,
                                          age: self.user.age,
                                          password: self.user.password) { result in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Account successfully created")
                            }
                        }
                        
                    }) {
                        Text("Register")
                            .padding(.vertical, 10)
                            .frame(width: 200)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .font(.caption)
                            .cornerRadius(20)
                            .opacity(user.isSignInComplete ? 1 : 0.75)
                    }
                    .disabled(!user.isSignInComplete)
                    Spacer()
                }.padding()
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error creating account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
