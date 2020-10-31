//
//  MatchesView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/19/20.
//

import SwiftUI

struct MatchesView: View {
    var store = UsersStore()
    
    var count: Int = 0
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9886991734, green: 0.6800984073, blue: 0.7332561142, alpha: 1)).ignoresSafeArea()
            VStack {
                Text("Matches")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                            ForEach(store.users, id: \.self) { user in
                                Image(store.users[user.id].img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.5 - 40, height: geometry.size.height * 0.25)
                                    .clipped()
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    .sheet(item: <#T##Binding<Identifiable?>#>, content: <#T##(Identifiable) -> View#>)
                            }
                        }
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
