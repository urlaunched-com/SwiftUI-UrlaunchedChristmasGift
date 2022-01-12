//
//  ChooseTheGiftView.swift
//  ChristmasGift
//
//  Created by Alexander Sharko on 29.12.2021.
//

import SwiftUI

struct ChooseTheGiftView: View {
    
    @State private var giftFromYouAreLaunchedIsPresented = false
    @State private var giftFromMicrosoftIsPresented = false
    @State private var giftFromSantaIsPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Choose you gift")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            giftButton(image: .launched, color: .black, action: { giftFromYouAreLaunchedIsPresented.toggle() })
                .fullScreenCover(isPresented: $giftFromYouAreLaunchedIsPresented) {
                    GiftView(
                        snowflake: UIImage(named: "launched")?.cgImage,
                        snowColor: UIColor.yellow.cgColor,
                        sled: Image.rocket,
                        sledColor: Color.yellow
                    )
                }
            
            giftButton(image: .santa, color: .christmasRed, action: { giftFromSantaIsPresented.toggle() })
                .fullScreenCover(isPresented: $giftFromSantaIsPresented) {
                    GiftView(
                        boxColor: .christmasRed,
                        tapeColor: .christmasYellow,
                        backgroundColor: .christmasGreen,
                        snowflake: UIImage(named: "snowflake")?.cgImage,
                        snowColor: UIColor.white.cgColor,
                        gift: Image.girl,
                        sled: Image.sled,
                        sledColor: .white
                    )
                }
            
            giftButton(image: .windows, color: .windowsBlue, action: { giftFromMicrosoftIsPresented.toggle() })
                .fullScreenCover(isPresented: $giftFromMicrosoftIsPresented) {
                    GiftView(
                        boxColor: .windowsGray,
                        tapeColor: .white,
                        backgroundColor: .windowsBlue,
                        snowflake: UIImage(named: "explorer")?.cgImage,
                        snowColor: UIColor.white.cgColor,
                        gift: Image.error,
                        sled: Image.microsoftTruck
                    )
                }
            Spacer()
        }
        .foregroundColor(Color.black)
        .font(.title)
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
    
    private func giftButton(image: Image, color: Color, action: @escaping () -> ()) -> some View {
        Button(action: action) {
            image
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding()
        .background(
            Capsule()
                .fill(color)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTheGiftView()
    }
}
