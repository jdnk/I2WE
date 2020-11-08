//
//  FBAuth.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import AuthenticationServices

struct FBAuth {
    // MARK: - Sign In with Email functions
    
    static func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
        )}
    
    static func authenticate(withEmail email :String,
                             password:String,
                             completionHandler:@escaping (Result<Bool, EmailAuthError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // check the NSError code and convert the error to an AuthError type
            var newError:NSError
            if let err = error {
                newError = err as NSError
                var authError:EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError!))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // MARK: - FB Firestore User creation
    static func createUser(withEmail email:String,
                           firstName: String,
                           lastName: String,
                           age: Int,
                           password:String,
                           completionHandler:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                completionHandler(.failure(err))
                return
            }
            guard let _ = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            let data = FBUser.dataDict(uid: authResult!.user.uid,
                                       email: authResult!.user.email!,
                                       firstName: firstName,
                                       lastName: lastName,
                                       age: age
            )
            
            FBFirestore.mergeFBUser(data, uid: authResult!.user.uid) { (result) in
                completionHandler(result)
            }
            completionHandler(.success(true))
        }
    }
    
    // MARK: - FB Firestore User update
    static func updateUser(password:String,
                           email:String,
                           firstName: String,
                           lastName: String,
                           age: Int,
                           imgs: [Int:UIImage] = [:],
                           pronouns: Int = -1,
                           loc: [String] = [],
                           bio: String = "",
                           emoji: String = "",
                           zodiac: Int = -1,// -1=none
                           mbti: Int = -1 // Meyers-Briggs
                           ) {
        let data: [String : Any] = [
                                FBKeys.User.email: email,
                                FBKeys.User.firstName: firstName,
                                FBKeys.User.lastName: lastName,
                                FBKeys.User.age: age,
                                FBKeys.User.imgs: imgs,
                                FBKeys.User.pronouns: pronouns,
                                FBKeys.User.loc: loc,
                                FBKeys.User.bio: bio,
                                FBKeys.User.emoji: emoji,
                                FBKeys.User.zodiac: zodiac,
                                FBKeys.User.mbti: mbti
                                ]
        
        Firestore.firestore().collection(FBKeys.CollectionPath.users).document(Auth.auth().currentUser!.uid).setData(data) { err in
            if let err = err {
                print("Error updating user info")
            }
            else {
                print("Successfully updated!")
            }
        }
    }
    
    // MARK: - FB Firestore User fetch
    static func getCurUser() -> [String: Any] {
        var data: [String: Any] = [:]
        Firestore.firestore().collection(FBKeys.CollectionPath.users).document(Auth.auth().currentUser!.uid).getDocument() { (doc, err) in
            if let doc = doc, doc.exists {
                data = doc.data()!
                } else {
                print("Document does not exist")
            }
        }
        return data
    }
    
//    // MARK: - FB Firestore User fetch
//    static func getCurUser() -> Int {
//        Firestore.firestore().collection(FBKeys.CollectionPath.users).document(Auth.auth().currentUser!.uid).getDocument() { (doc, err) in
//            if let doc = doc, doc.exists {
//                let dataDescription = doc.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data: \(dataDescription)")
//                print("Good doc!")
//                } else {
//                print("Document does not exist")
//            }
//        }
//        return 0
//    }
    
    // MARK: - Logout
    
    static func logout(completion: @escaping (Result<Bool, Error>) -> ()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }
    
}
