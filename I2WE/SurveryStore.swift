//
//  SurveryStore.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI

import Combine

class SurveyStore: ObservableObject {
    @Published var survey: [Question] = [
        Question(id: 0, question: "What is the name of your firstborn child?", choices: ["Test", "Test B", "Test C", "Test 4"]),
        Question(id: 1, question: "What is the name of your secondborn child?", choices: ["Ramiel", "Triangle B", "Forty", "TJohn"]),
        Question(id: 1, question: "asdfadsfasfsdlkfasjd?", choices: ["ada", "fds B", "fasd", "asdf"])
    ]
}
