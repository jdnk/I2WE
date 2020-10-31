//
//  CardView.swift
//  I2WE
//
//  Created by Jaden Kim on 10/31/20.
//

import SwiftUI

struct CardView: View {

    @Binding var user: User
    @Binding var onRemove: (_ user: User) -> Void
    
    @State private var flipped = false
    @State private var animate3d = false

    var body: some View {

        return VStack {
            Spacer()

            ZStack() {
                FrontCard(user, onRemove).opacity(flipped ? 0.0 : 1.0)
                BackCard(user, onRemove).opacity(flipped ? 1.0 : 0.0)
            }
            .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 1, y: 0)))
            .onTapGesture {
                withAnimation(Animation.linear(duration: 0.8)) {
                        self.animate3d.toggle()
                }
            }
            Spacer()
        }
    }
}

struct FlipEffect: GeometryEffect {

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)

    func effectValue(size: CGSize) -> ProjectionTransform {

        DispatchQueue.main.async {
              self.flipped = self.angle >= 90 && self.angle < 270
        }

        let tweakedAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)

        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)

        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))

        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct FrontCard: View {
    @State var translation: CGSize = .zero
    
    var yesColor = Color.green
    var noColor = Color.red
    @State var yes: Bool = false
    @State var no: Bool = false
    @State var bgColor: Color = Color.white
    @State var textColor: Color = Color.black
    
    var threshold: CGFloat = 0.5
    
    @Binding var user: User
    @Binding var onRemove: (_ user: User) -> Void
    
//    init(user: User, onRemove: @escaping (_ user: User) -> Void) {
//        self.user = user
//        self.onRemove = onRemove
//    }
    
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
                    .padding(.top, 10)
                }
                .background(bgColor)
                .border(textColor, width: 3)
                .animation(.linear)
                // .animation(.interactiveSpring())
                // .offset(x: self.translation.width, y: 0)
                // .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .bottom)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                            if value.translation.width > 0 {
                                self.yes = true
                                self.no = false
                                self.bgColor = yesColor
                                self.textColor = Color.white
                                user.swiped = true
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
                                user.swiped = true
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

struct BackCard : View {
    @State var translation: CGSize = .zero
    
    var yesColor = Color.green
    var noColor = Color.red
    @State var yes: Bool = false
    @State var no: Bool = false
    @State var bgColor: Color = Color.white
    @State var textColor: Color = Color.black
    
    var threshold: CGFloat = 0.5
    
    @Binding var user: User
    @Binding var onRemove: (_ user: User) -> Void
    
//    init(user: User, onRemove: @escaping (_ user: User) -> Void) {
//        self.user = user
//        self.onRemove = onRemove
//    }
    
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
                    .padding(.top, 10)
                }
                .background(bgColor)
                .border(textColor, width: 3)
                .animation(.linear)
                // .animation(.interactiveSpring())
                // .offset(x: self.translation.width, y: 0)
                // .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .bottom)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                            if value.translation.width > 0 {
                                self.yes = true
                                self.no = false
                                self.bgColor = yesColor
                                self.textColor = Color.white
                                user.swiped = true
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
                                user.swiped = true
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
        Text("Hello, World!")
    }
}
