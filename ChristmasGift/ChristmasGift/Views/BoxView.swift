//
//  BoxView.swift
//  ChristmasGift
//
//  Created by Alexander Sharko on 27.12.2021.
//

import SwiftUI

struct BoxView: View {
    var color = Color.green
    var tapeColor = Color.blue
    var size: CGSize
    
    var body: some View {
        ZStack {
            VStack(spacing: -size.height / 12) {
                boxTieView
                    .frame(width: size.width / 2, height: size.height / 2.5)
                boxBottomView
                    .frame(width: size.width, height: size.height)
            }
        }
    }
}

private extension BoxView {
    var boxTieView: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: -size.width / 12) {
                Triangle()
                    .fill(tapeColor.opacity(0.7))
                    .rotationEffect(.degrees(-40))
                Triangle()
                    .fill(tapeColor)
                    .rotationEffect(.degrees(40))
            }
            Circle()
                .fill(tapeColor)
                .frame(width: size.width / 6, height: size.height / 6)
        }
    }
    
    var boxBottomView: some View {
        ZStack {
            color
                .cornerRadius(5)
            HStack(spacing: 0) {
                Spacer()
                tapeColor
                    .frame(width: size.width / 6)
                Spacer()
                Color
                    .black
                    .opacity(0.15)
                    .cornerRadius(5)
                    .frame(width: size.width / 3)
                    .background(
                        tapeColor
                            .frame(width: size.width / 12)
                    )
            }
        }
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        BoxView(size: CGSize(width: screenWidth / 2, height: screenWidth / 2.5))
    }
}
