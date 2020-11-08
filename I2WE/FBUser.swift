//
//  FBUser.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import Foundation
import SwiftUI

struct FBUser {
    // reqs
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var age: Int
    
    // opts
    var imgs: [Int:UIImage] = [:]
    var pronouns: Int = -1
    var loc: [String] = []
    var bio: String = ""
    var emoji: String = ""
    var zodiac: Int = -1// -1=none
    var mbti: Int = -1 // Meyers-Briggs
    
    // search prefs
    var pref: Int = 0 // 0=everyone, 1=men, 2=women
    var agePref: [Int] = [18, 70] // 70+

    // matching
    var swiped: [String] = []
    var swipedBy: [String] = []
    
    // etc
    var description: String {
        return "uid: \(uid), email: \(email)"
    }
    
    init(uid: String, email: String, firstName: String, lastName: String, age: Int, imgs: [Int:UIImage] = [:], pronouns: Int = -1, loc: [String] = [], bio: String = "", emoji: String = "", zodiac: Int = -1, mbti: Int = -1, pref: Int = -1, agePref: [Int] = [], swiped: [String] = [], swipedBy: [String] = []) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        self.imgs = imgs
        self.pronouns = pronouns
        self.loc = loc
        self.bio = bio
        self.emoji = emoji
        self.zodiac = zodiac
        self.mbti = mbti
        
        self.pref = pref
        self.agePref = agePref
        
        self.swiped = swiped
        self.swipedBy = swipedBy
        
    }

}

extension FBUser {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
        let firstName = documentData[FBKeys.User.firstName] as? String ?? ""
        let lastName = documentData[FBKeys.User.lastName] as? String ?? ""
        let age = documentData[FBKeys.User.age] as? Int ?? -1
        
        let imgs = documentData[FBKeys.User.imgs] as? [Int:UIImage] ?? [:]
        let pronouns = documentData[FBKeys.User.pronouns] as? Int ?? -1
        let loc = documentData[FBKeys.User.loc] as? [String] ?? []
        let bio = documentData[FBKeys.User.bio] as? String ?? ""
        let emoji = documentData[FBKeys.User.emoji] as? String ?? ""
        let zodiac = documentData[FBKeys.User.zodiac] as? Int ?? -1
        let mbti = documentData[FBKeys.User.mbti] as? Int ?? -1
        
        let pref = documentData[FBKeys.User.pref] as? Int ?? -1
        let agePref = documentData[FBKeys.User.imgs] as? [Int] ?? []
        
        let swiped = documentData[FBKeys.User.swiped] as? [String] ?? []
        let swipedBy = documentData[FBKeys.User.swipedBy] as? [String] ?? []
        
        self.init(uid: uid,
                  email: email,
                  firstName: firstName,
                  lastName: lastName,
                  age: age,
                  imgs: imgs,
                  pronouns: pronouns,
                  loc: loc,
                  bio: bio,
                  emoji: emoji,
                  zodiac: zodiac,
                  mbti: mbti,
                  pref: pref,
                  agePref: agePref,
                  swiped: swiped,
                  swipedBy: swipedBy
        )
    }
    
    static func dataDict(uid: String, email: String, firstName: String, lastName: String, age: Int, imgs: [Int:UIImage] = [:], pronouns: Int = -1, loc: [String] = [], bio: String = "", emoji: String = "", zodiac: Int = -1, mbti: Int = -1, pref: Int = -1, agePref: [Int] = [], swiped: [String] = [], swipedBy: [String] = []) -> [String: Any] {
        
        var data: [String: Any] = [:]
        
        // new user sign up ish
        if firstName != "" {
            data = [
                FBKeys.User.uid: uid,
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
                FBKeys.User.mbti: mbti,
                FBKeys.User.pref: pref,
                FBKeys.User.agePref: agePref,
                FBKeys.User.swiped: swiped,
                FBKeys.User.swipedBy: swipedBy
            ]
        } else {
            // returning user sign in ish
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email
            ]
        }
        return data
    }
}
