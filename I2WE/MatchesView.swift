//
//  MatchesView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/19/20.
//

import SwiftUI

struct MatchesView: View {
    var store = UsersStore()
    @State var showMatch: Bool = false
    @State var curID: Int = -1
    
    var count: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    ForEach(store.users, id: \.self) { user in
                        Button(action: {
                            self.curID = user.id
                            self.showMatch.toggle()
                        }) {
                            Image(store.users[user.id].img)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width * 0.5 - 40, height: geometry.size.width * 0.5 - 40)
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                                .padding(.top, 10)
                                .padding(.horizontal, 20)
                        }
                        .sheet(isPresented: $showMatch, content: {
                            ProfileView(id: curID)
                        })
                    }
                }
            }
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
