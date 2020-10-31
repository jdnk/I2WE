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
        User(id: 0, firstName: "Jaden", lastName: "Kim", age: 47, img: "test", city: "Claremont", state: "CA"),
        User(id: 1, firstName: "Elena", lastName: "Mujal", age: 78, img: "elena", city: "Claremont", state: "CA"),
        User(id: 2, firstName: "Abigail", lastName: "Andrews", age: 88, img: "abigail", city: "Claremont", state: "CA"),
        User(id: 3, firstName: "Swamik", lastName: "Lamichhane", age: 20, img: "swamik", city: "Claremont", state: "CA"),
        User(id: 4, firstName: "Jaden", lastName: "Kim", age: 47, img: "test", city: "Claremont", state: "CA"),
        User(id: 5, firstName: "Elena", lastName: "Mujal", age: 78, img: "elena", city: "Claremont", state: "CA"),
        User(id: 6, firstName: "Abigail", lastName: "Andrews", age: 88, img: "abigail", city: "Claremont", state: "CA"),
        User(id: 7, firstName: "Swamik", lastName: "Lamichhane", age: 20, img: "swamik", city: "Claremont", state: "CA")
    ]
}
