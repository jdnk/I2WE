//
//  User.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI

struct User: Hashable, CustomStringConvertible, Identifiable {
    var id: Int
    var email: String
    var password: String
    
    let firstName: String
    let lastName: String
    var age: Int
    var img: String
    var pronouns: Int
    var city: String = "None"
    var state: String = "None"
    var pref: Int = 0 // 0=everyone, 1=men, 2=women
    var bio: String = "None"
    var emoji: String = "None"
    var zodiac: Int = -1// -1=none
    var mbti: String = "None" // Meyers-Briggs
    var loAge: Int = 18
    var hiAge: Int = 70 // 70+

    var swiped: Bool = false
    
    var description: String {
        return "id: \(id), name: \(firstName), swiped: \(swiped)"
    }
}


