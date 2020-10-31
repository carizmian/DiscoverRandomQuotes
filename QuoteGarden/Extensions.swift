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

extension GetRect {
    struct RectPreferenceKey: PreferenceKey {
        static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
            value = nextValue()
        }

        typealias Value = CGRect?

        static var defaultValue: CGRect?
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

extension CGRect {
    var uiImage: UIImage? {
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first?.rootViewController?.view
            .asImage(rect: self)
    }
}

extension View {
    func getRect(_ rect: Binding<CGRect>) -> some View {
        self.modifier(GetRect(rect: rect))
    }
}
