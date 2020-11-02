//
//  AccountView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var store = UsersStore()
    
    @State var showPhotoLibrary = false
    @State var img = UIImage()
    
    private var id: Int = 0
    
    var count: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(0..<4) { i in
                    Button(action: {
                        self.showPhotoLibrary = true
                        store.users[id].imgs[i] = img
                    }) {
                        Image(systemName: "plus")
                            .background(Color.white)
                            .frame(width: geometry.size.width * 0.5 - 40, height: geometry.size.width * 0.5 - 40)
                            .clipped()
                                .border(Color.black, width: 3)
                                .padding(.top, 10)
                            .padding(.horizontal, 20)
                    }
                    }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
