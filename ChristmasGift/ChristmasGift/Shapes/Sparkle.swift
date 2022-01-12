//
//  Sparkle.swift
//  ChristmasGift
//
//  Created by Alexander Sharko on 28.12.2021.
//

import SwiftUI

struct Sparkle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control1: CGPoint(x: rect.midX / 2, y: rect.midY),
            control2: CGPoint(x: rect.midX, y: rect.midY)
        )
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control1: CGPoint(x: rect.midX, y: rect.midY),
            control2: CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY)
        )
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control1: CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY),
            control2: CGPoint(x: rect.midX, y: rect.midY)
        )
        path.addCurve(
            to: CGPoint(x: rect.minX, y: rect.midY),
            control1: CGPoint(x: rect.midX, y: rect.midY),
            control2: CGPoint(x: rect.midX / 2, y: rect.midY)
        )

        return path
    }
}

struct Sparkle_Previews: PreviewProvider {
    static var previews: some View {
        Sparkle()
    }
}
