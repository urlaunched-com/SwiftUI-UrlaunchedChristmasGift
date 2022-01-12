//
//  Gift.swift
//  GiftView
//
//  Created by Alexander Sharko on 27.12.2021.
//

import SwiftUI

struct GiftView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var boxColor: Color
    var tapeColor: Color
    var backgroundColor: Color?
    var snowflake: CGImage?
    var snowColor: CGColor?
    var snowAmount: Float
    var snowVelocity: CGFloat
    var gift: Image
    var sled: Image
    var sledColor: Color?
    
    init(
        boxColor: Color = .yellow,
        tapeColor: Color = .gray,
        backgroundColor: Color? = nil,
        snowflake: CGImage?,
        snowColor: CGColor?,
        snowAmount: Float = 2,
        snowVelocity: CGFloat = 80,
        gift: Image = Image.hoodie,
        sled: Image = Image.sled,
        sledColor: Color? = nil
    ) {
        self.boxColor = boxColor
        self.tapeColor = tapeColor
        self.backgroundColor = backgroundColor
        self.snowflake = snowflake
        self.snowColor = snowColor
        self.snowAmount = snowAmount
        self.snowVelocity = snowVelocity
        self.gift = gift
        self.sled = sled
        self.sledColor = sledColor
    }
    
    @State private var offset: CGFloat = screenHeight
    @State private var scale: CGFloat = 1
    @State private var rotation: CGFloat = 0
    @State private var visibility: CGFloat = 1
    @State private var sparkleScale: CGFloat = 0.5
    @State private var giftIsUnboxed = false
    @State private var giftIsTaken = false
    @State private var sledOffset: CGFloat = -screenWidth
    
    var body: some View {
        ZStack() {
            if let backgroundColor = backgroundColor {
                backgroundColor.ignoresSafeArea()
            }
            SnowView(
                image: snowflake,
                color: snowColor,
                amount: snowAmount,
                velocity: snowVelocity
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                ZStack {
                    giftView
                    boxView
                }
                Spacer()
                sledView
            }
        }
        .onAppear {
            offset = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                sparkleScale = 1.5
            }
        }
    }
}

private extension GiftView {
    
    var sledView: some View {
        sled
            .resizable()
            .renderingMode(sledColor != nil ? .template : .original)
            .scaledToFit()
            .foregroundColor(sledColor)
            .frame(width: screenWidth - 16, height: screenWidth / 2)
            .offset(x: sledOffset, y: 0)
            .animation(.easeInOut(duration: 1))
        }
    
    var giftView: some View {
        gift
            .resizable()
            .scaledToFit()
            .shadow(color: .black.opacity(0.15), radius: 10, x: 10 * rotation, y: 10 * rotation)
            .opacity(giftIsUnboxed ? 1 : 0)
            .scaleEffect(giftIsUnboxed ? 1 : 0)
            .animation(.spring().speed(1.3))
            .frame(maxWidth: screenWidth * 0.8)
            .rotation3DEffect(
                .init(degrees: rotation * 3),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.default.repeatForever().speed(0.3))
            .scaleEffect(giftIsTaken ? scale : 1)
            .offset(x: 0, y: giftIsTaken ? screenHeight / 2 : 0)
            .animation(.easeInOut(duration: 0.7))
            .opacity(giftIsTaken ? 0 : 1)
            .animation(.easeOut.delay(0.3))
            .onTapGesture(perform: take)
    }
    
    var boxView: some View {
        BoxView(
            color: boxColor,
            tapeColor: tapeColor,
            size: CGSize(width: screenWidth / 2, height: screenWidth / 2.5)
        )
        .shadow(color: .black.opacity(0.15), radius: 10, x: 10, y: 10)
        .padding()
        .offset(x: 0, y: offset)
        .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 1))
        .scaleEffect(scale)
        .animation(.easeInOut(duration: 1))
        .rotationEffect(.degrees(rotation))
        .animation(.easeOut.repeatCount(30, autoreverses: true).speed(6))
        .opacity(visibility)
        .animation(.linear(duration: 0.15))
        .onTapGesture(perform: unbox)
        .overlay(sparkle(), alignment: .leading)
        .overlay(sparkle(speed: 1.3), alignment: .top)
        .overlay(sparkle(speed: 0.7), alignment: .bottomTrailing)
    }
    
    var sparklesView: some View {
        HStack {
            Spacer()
            VStack {
                sparkle()
                Spacer()
                sparkle(speed: 1.3)
            }
            Spacer()
            VStack {
                sparkle(speed: 0.7)
                    
            }
            Spacer()
        }
    }
    
    func sparkle(speed: Double = 1) -> some View {
        Sparkle()
            .fill(Color.white)
            .scaleEffect(sparkleScale)
            .opacity(sparkleScale < 1 ? 0 : 1)
            .animation(.spring().repeatForever().speed(speed))
            .frame(width: screenWidth / 16, height: screenWidth / 8)
            .padding()
    }
    
    func unbox() {
        scale = 1.5
        sparkleScale = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            rotation = 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            visibility = 0
            scale = 15
            giftIsUnboxed = true
            sparkleScale = 1.5
        }
    }
    
    func take() {
        sledOffset = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            scale = 0
            giftIsTaken = true
            sparkleScale = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            sledOffset = screenWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct Gift_Previews: PreviewProvider {
    static var previews: some View {
        GiftView(
            snowflake: UIImage(named: "launched")?.cgImage,
            snowColor: UIColor.yellow.cgColor
        )
    }
}
