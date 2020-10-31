//
//  Question.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI

struct Question: Hashable, CustomStringConvertible, Identifiable {
    var id: Int
    
    let question: String
    let choices: [String]
    var selection: Int = -1
    
    var description: String {
        return "\(selection), id: \(id)"
    }
}
