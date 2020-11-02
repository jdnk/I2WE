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
    let yesColor = Color(#colorLiteral(red: 0.01960784314, green: 0.2470588235, blue: 0.1725490196, alpha: 1))
    let noColor = Color(#colorLiteral(red: 0.9241634088, green: 0.07058823529, blue: 0.1992600671, alpha: 1))
    
    @State var flipCard: Bool = false

    @ObservedObject var zodiac = ZodiacStore()
    @ObservedObject var pronouns = PronounStore()
      
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
    
    func getScrollAmount(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.height / geometry.size.height
    }
    
    var body: some View {
        let zod: Int = self.user.zodiac
        let pro: Int = self.user.pronouns
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(self.user.img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width - 40, height: geometry.size.height - 40)
                    .clipped()
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                    VStack(alignment: .leading) {
                            HStack() {
                                Text("\(self.user.firstName)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(textColor)
                                Text("\(self.user.age)")
                                    .font(.largeTitle)
                                    .foregroundColor(textColor)
                            }
                        HStack {
                            if (zod != -1) {
                                Text("\(zodiac.zodiac[zod]!)")
                            }
                            if (self.user.emoji != "None") {
                                Text("\(self.user.emoji)")
                            }
                        }
                        
                        HStack {
                            if (self.user.mbti != "None") {
                                Text("\(self.user.mbti)")
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
                            Text("\(self.user.city), \(self.user.state)")
                                    .font(.caption)
                                .foregroundColor(Color.white)
                                .padding(5)
                                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .cornerRadius(20)
                        }
                        }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
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
        CardView(user: User(id: 0, email: "jaden.kim@pomona.edu", password: "Testword47", firstName: "Jaden", lastName: "Kim", age: 47, img: "test", pronouns: 0, city: "Claremont", state: "CA", pref: 0, bio: "Test", emoji: "🐧", zodiac: 10, mbti: "ENFP"),
                         onRemove: { _ in
                            // do nothing
                    })
                    .frame(height: 400)
                    .padding()
    }
}
