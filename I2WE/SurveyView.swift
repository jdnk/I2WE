//
//  SurveyView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/26/20.
//

import SwiftUI

struct SurveyView: View {
    @ObservedObject var store = SurveyStore()
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            ForEach(store.survey) { question in
                VStack {
                    Text(question.question)
                        .font(.title)
                        .fontWeight(.bold)
                    ForEach(0..<question.choices.count) { choice in
                        Button(question.choices[choice]) {
                            question.selection = choice
                        }
                        // STYLING
                    }
                }
            }
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
    }
}
