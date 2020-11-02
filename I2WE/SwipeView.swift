//
//  SwipeView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/12/20.
//

import SwiftUI

struct SwipeView: View {
    @ObservedObject var store = UsersStore()
    
    // Compute what the max ID in the given users array is.
    private var maxID: Int {
        return store.users.map { $0.id }.max() ?? 0
    }
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(store.users.count - 1 - id) * 10
            return geometry.size.width - offset
        }
    
    var body: some View {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        ZStack {
                            ForEach(store.users, id: \.self) { user in
                                if user.id > self.maxID - 1 {
                                    CardView(user: user, onRemove: { removedUser in
                                       // Remove that user from our array
                                       store.users.removeAll { $0.id == removedUser.id }
                                      })
                                      .frame(width: self.getCardWidth(geometry, id: user.id),
                                             height: geometry.size.height - 127)
                                }
                            }
                        }
                    }
                }
            }.padding()
        }
    }

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
