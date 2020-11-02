//
//  ProfileView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var store = UsersStore()
    @ObservedObject var zodiac = ZodiacStore()
    @ObservedObject var pronouns = PronounStore()
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        let zod: Int = store.users[id].zodiac
        let pro: Int = store.users[id].pronouns
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Image(store.users[id].imgs[0]!) // FIX THIS
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipped()
                    VStack(alignment: .leading) {
                            HStack() {
                                Text("\(store.users[id].firstName) \(store.users[id].lastName)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("\(store.users[id].age)")
                                    .font(.largeTitle)
                            }
                        HStack {
                            if (zod != -1) {
                                Text("\(zodiac.zodiac[zod]!)")
                            }
                            if (store.users[id].emoji != "None") {
                                Text("\(store.users[id].emoji)")
                            }
                        }
                        
                        HStack {
                            if (store.users[id].mbti != "None") {
                                Text("\(store.users[id].mbti)")
                                        .font(.caption)
                                    .foregroundColor(Color.white)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                    .cornerRadius(20)
                            }
                            if (pro != -1) {
                                Text("\(pronouns.pronouns[pro]!)")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                    .cornerRadius(20)
                            }
                            Text("\(store.users[id].city), \(store.users[id].state)")
                                    .font(.caption)
                                .foregroundColor(Color.white)
                                .padding(5)
                                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .cornerRadius(20)
                        }
                        }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    if (store.users[id].bio != "None") {
                        Text("Bio")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        Text("\(store.users[id].bio)")
                            .font(.body)
                            .padding(.horizontal, 20)
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(id: 0)
    }
}
