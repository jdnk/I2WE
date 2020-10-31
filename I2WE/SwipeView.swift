//
//  SwipeView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/12/20.
//

import SwiftUI

struct SwipeView: View {
    @ObservedObject var store = UsersStore()
    
//    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
//        let offset: CGFloat = CGFloat(users.count - 1 - id) * 10
//        return geometry.size.width - offset
//    }
    
//    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
//        return CGFloat(users.count - 1 - id) * 10
//    }
    
    private var maxID: Int {
        return store.users.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.08712410182, green: 0.08219537884, blue: 0.1289232969, alpha: 1)).ignoresSafeArea()
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(store.users, id: \.self) { user in
                            if user.id > self.maxID-1 {
                                CardView(user: user, onRemove: { removedUser in
                                    store.users.removeAll { $0.id == removedUser.id }
                                    })
                                .frame(width: geometry.size.width, height: geometry.size.height - 250)
                                .background(Color.white)
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
