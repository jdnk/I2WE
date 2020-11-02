//
//  UsersStore.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI
import Combine

class UsersStore: ObservableObject {
    @Published var users: [User] = [
        User(id: 0, email: "jaden.kim@pomona.edu", password: "Testword47", firstName: "Jaden", lastName: "Kim", age: 47, img: "test", pronouns: 0, city: "Claremont", state: "CA", pref: 0, bio: "Wow look at this! Long bio with many characters it still works properly with the formatting", emoji: "🐧", zodiac: 10, mbti: "ENFP"),
        User(id: 1, email: "elena.mujal@pomona.edu", password: "Testword47", firstName: "Elena", lastName: "Mujal", age: 47, img: "elena", pronouns: 0, city: "Claremont", state: "CA", pref: 0, bio: "Test", emoji: "🐧", zodiac: 10, mbti: "ENFP"),
        User(id: 2, email: "swamik.lamichhane@hmc.edu", password: "Testword47", firstName: "Swamik", lastName: "Lamichhane", age: 47, img: "swamik", pronouns: 0, city: "Claremont", state: "CA", pref: 0, bio: "Test", emoji: "🐧", zodiac: 10, mbti: "ENFP"),
        User(id: 3, email: "abigail.andrews@pomona.edu", password: "Testword47", firstName: "Abigail", lastName: "Andrews", age: 47, img: "abigail", pronouns: 0, city: "Claremont", state: "CA", pref: 0, bio: "Test", emoji: "🐧", zodiac: 10, mbti: "ENFP")
    ]
}
