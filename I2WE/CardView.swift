//
//  CardView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/1/20.
//

import SwiftUI

struct CardView: View {
    
    @State var translation: CGSize = .zero
    
    @State var yes: Bool = false
    @State var no: Bool = false
    @State var bgColor: Color = Color.white
    @State var textColor: Color = Color.black
    let yesColor = Color.green
    let noColor = Color.red
    
    @State var flipCard: Bool = false

    // 1
    private var user: User
    private var onRemove: (_ user: User) -> Void
    
     // 2
    private var threshold: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    
    // 3
    init(user: User, onRemove: @escaping (_ user: User) -> Void) {
        self.user = user
        self.onRemove = onRemove
    }
    
    func getSwipeAmount(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(self.user.img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width - 40, height: geometry.size.height - 40)
                    .clipped()
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                    HStack {
                        VStack(alignment: .leading) {
                                HStack() {
                                    Text("\(self.user.firstName)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(textColor)
                                        .animation(.linear)
                                    Text("\(self.user.age)")
                                        .font(.title)
                                        .foregroundColor(textColor)
                                        .animation(.linear)
                                }
                                Text("\(self.user.city), \(self.user.state)")
                                    .font(.caption)
                                    .foregroundColor(textColor)
                                    .animation(.linear)
                            }
                            .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        Spacer()
                        Button(action: {self.flipCard.toggle()}) {
                            Image(systemName: "info.circle")
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                .foregroundColor(textColor)
                                .animation(.linear)
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                }
                .background(bgColor)
                .border(textColor, width: 3)
                .animation(.linear)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                            if value.translation.width > 0 {
                                self.yes = true
                                self.no = false
                                self.bgColor = yesColor
                                self.textColor = Color.white
//                                self.user.swiped = true
                            } else if value.translation.width < 0 {
                                self.yes = false
                                self.no = true
                                self.bgColor = noColor
                                self.textColor = Color.white
                            } else {
                                self.yes = false
                                self.no = false
                                self.bgColor = Color.white
                                self.textColor = Color.black
                            }
                        }
                        .onEnded { value in
                            self.yes = false
                            self.no = false
                            if abs(self.getSwipeAmount(geometry, from: value)) > self.threshold {
                                self.onRemove(self.user)
//                                self.user.swiped = true
                            } else {
                                self.translation = .zero
                                self.yes = false
                                self.no = false
                                self.bgColor = Color.white
                                self.textColor = Color.black
                            }
                        }
                )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(user: User(id: 0, firstName: "Jaden", lastName: "Kim", age: 47, img: "test", city: "Claremont", state: "CA"),
                         onRemove: { _ in
                            // do nothing
                    })
                    .frame(height: 400)
                    .padding()
    }
}
