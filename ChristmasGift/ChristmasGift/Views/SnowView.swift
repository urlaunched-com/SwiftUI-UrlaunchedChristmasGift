//
//  SnowView.swift
//  ChristmasGift
//
//  Created by Alexander Sharko on 28.12.2021.
//

import SwiftUI

struct SnowView: UIViewRepresentable {
    
    var image: CGImage?
    var color: CGColor?
    var amount: Float
    var velocity: CGFloat
    
    init(
        image: CGImage?,
        color: CGColor?,
        amount: Float = 2,
        velocity: CGFloat = 80
    ) {
        self.image = image
        self.color = color
        self.amount = amount
        self.velocity = velocity
    }
    
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        emitterLayer.emitterSize = CGSize(width: screenWidth, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: screenWidth / 2, y: 0)
        view.layer.addSublayer(emitterLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func createEmitterCells() -> [CAEmitterCell] {
        let cell = CAEmitterCell()
        cell.contents = image
        cell.color = color
        cell.birthRate = amount
        cell.lifetime = 20
        cell.velocity = velocity
        cell.scale = 0.1
        cell.scaleRange = 0.15
        cell.emissionLongitude = .pi
        cell.spin = 1
        cell.spinRange = 2
        cell.yAcceleration = 1
        return [cell]
    }
}

struct SnowView_Previews: PreviewProvider {
    static var previews: some View {
        SnowView(
            image: UIImage(named: "launched")?.cgImage,
            color: UIColor.yellow.cgColor
        )
    }
}
