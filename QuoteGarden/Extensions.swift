//
//  Extensions.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import Foundation
import SwiftUI

extension QuoteCD {
    var wrappedQuoteAuthor: String {
        return quoteAuthor ?? "Unknown Author"
    }

    var wrappedQuoteText: String {
        return quoteText ?? "Unknown Quote Text"
    }

    var wrappedQuoteGenre: String {
        return quoteGenre ?? "Unknown Quote Genre"
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .overlay(self.blur(radius: radius / 6))
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

extension View {
    func multicolorGlow() -> some View {
        ZStack {
            ForEach(0..<2) { number in
                Rectangle()
                    .fill(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center))
                    .frame(width: 400, height: 300)
                    .mask(self.blur(radius: 20))
                    .overlay(self.blur(radius: 5 - CGFloat(number * 5)))
                // + atach this to the view
                // .overlay(self.blur(radius: CGFloat(i * 2)))
            }
        }
    }
}
