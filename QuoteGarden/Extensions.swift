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
