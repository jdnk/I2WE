//
//  ContentView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/12/20.
//

import SwiftUI

struct User: Hashable, CustomStringConvertible {
    var id: Int
    
    let firstName: String
    let lastName: String
    let age: Int
    let img: String
    let city: String
    let state: String
    
    var description: String {
        return "\(firstName), id: \(id)"
    }
}

struct ContentView: View {
    @State var users: [User] = [
        User(id: 0, firstName: "Daniel", lastName: "Kim", age: 20, img: "test", city: "Fullerton", state: "CA"),
        User(id: 1, firstName: "Jaden", lastName: "Kim", age: 21, img: "ye", city: "Claremont", state: "CA"),
        User(id: 2, firstName: "Elena", lastName: "Mujal", age: 20, img: "test", city: "Claremont", state: "CA"),
        User(id: 3, firstName: "Abigail", lastName: "Andrews", age: 20, img: "ye", city: "Claremont", state: "CA")
    ]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(users.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return CGFloat(users.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.users.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ForEach(self.users, id: \.self) { user in
                        if user.id > self.maxID - 3 {
                            CardView(user: user, onRemove: { removedUser in
                                self.users.removeAll { $0.id == removedUser.id }
                                })
                                .animation(.spring())
                                .frame(width: self.getCardWidth(geometry, id: user.id),
                                       height: 400)
                                .offset(x: 0, y: self.getCardOffset(geometry, id: user.id))
                                .frame(width: self.getCardWidth(geometry, id: user.id), height: 400)
                                .offset(x: 0, y: getCardOffset(geometry, id: user.id))
                        }
                    }
                }
            }
            .padding(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    @State private var translation: CGSize = .zero
    
    @State private var yes: Bool = false
    @State private var no: Bool = false
    
    private var user: User
    private var onRemove: (_ user: User) -> Void
    
    private var threshold: CGFloat = 0.5
    
    init(user: User, onRemove: @escaping (_ user: User) -> Void) {
        self.user = user
        self.onRemove = onRemove
    }
    
    private func getSwipeAmount(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(self.user.img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width - 40, height: geometry.size.height * 0.6)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                
                HStack() {
                    VStack(alignment: .leading) {
                        HStack() {
                            Text("\(self.user.firstName) \(self.user.lastName)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(self.user.age)")
                                .font(.title)
                        }
                        Text("\(self.user.city), \(self.user.state)")
                            .font(.caption)
                    }
                    
                    Spacer()
                    Text("ℹ︎")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .padding(.top, 10)
            }
            .background(no ? Color.red : (yes ? Color.green : Color.white))
            .animation(.linear)
            .cornerRadius(20)
            .shadow(radius: 20)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        if value.translation.width > 0 {
                            self.yes = true
                            self.no = false
                        } else if value.translation.width < 0 {
                            self.yes = false
                            self.no = true
                        } else {
                            self.yes = false
                            self.no = false
                        }
                    }
                    .onEnded { value in
                        self.yes = false
                        self.no = false
                        if abs(self.getSwipeAmount(geometry, from: value)) > self.threshold {
                            self.onRemove(self.user)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}
