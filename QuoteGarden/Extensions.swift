//
//  Extensions.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import Foundation
import SwiftUI
import CoreData

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

//public extension URL {
//
//    /// Returns a URL for the given app group and database pointing to the sqlite database.
//    static func storeURL(for appGroup: String, databaseName: String) -> URL {
//        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
//            fatalError("Shared file container could not be created.")
//        }
//
//        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
//    }
//}
