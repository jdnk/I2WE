//
//  User.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI

struct User: Hashable, CustomStringConvertible, Identifiable {
    var id: Int
    
    let firstName: String
    let lastName: String
    let age: Int
    let img: String
    let city: String
    let state: String
    var swiped: Bool = false
    
    var description: String {
        return "\(firstName), id: \(id)"
    }
}
