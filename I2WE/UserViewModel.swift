//
//  UserViewModel.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI
import Foundation

struct UserViewModel: Hashable {
    // required for sign up
    var email: String
    var password: String
    var confirmPassword: String = ""
    var firstName: String
    var lastName: String
    var age: Int
    
    // optional
    var imgs: [Int:UIImage] = [:]
    var pronouns: Int = -1
    var loc: [String] = []
    var bio: String = ""
    var emoji: String = ""
    var zodiac: Int = -1// -1=none
    var mbti: Int = -1 // Meyers-Briggs
    
    // MARK: - Validation Checks

    func passwordsMatch(_confirmPW:String) -> Bool {
        return _confirmPW == password
    }

    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isEmailValid(_email: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return passwordTest.evaluate(with: email)
    }


    func isPasswordValid(_password: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isAgeValid(_age: Int) -> Bool {
        // Age must be an Int, at least 18 and no upper bound (inclusive)
        return (age>=18)
    }

    var isSignInComplete:Bool  {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: firstName) ||
            isEmpty(_field: lastName) ||
            !isPasswordValid(_password: password) ||
            !passwordsMatch(_confirmPW: confirmPassword){
            return false
        }
        return true
    }

    var isLogInComplete:Bool {
        if isEmpty(_field: email) ||
            isEmpty(_field: password) {
            return false
        }
        return true
    }

    // MARK: - Validation Error Strings
    var validFirstNameText: String {
        if !isEmpty(_field: firstName) {
            return ""
        } else {
            return "Enter your first name"
        }
    }
    
    var validLastNameText: String {
        if !isEmpty(_field: lastName) {
            return ""
        } else {
            return "Enter your last name"
        }
    }
    
    var validAgeText: String {
        if isAgeValid(_age: age) {
            return ""
        } else {
            return "You must be at least 18 years old to register"
        }
    }

    var validEmailAddressText:String {
        if isEmailValid(_email: email) {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }

    var validPasswordText:String {
        if isPasswordValid(_password: password) {
            return ""
        } else {
            return "Must be 8 characters containing at least one number and one Capital letter."
        }
    }

    var validConfirmPasswordText: String {
        if passwordsMatch(_confirmPW: confirmPassword) {
            return ""
        } else {
            return "Password fields do not match."
        }
    }
}
