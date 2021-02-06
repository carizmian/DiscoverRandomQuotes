//
//  ViewToUIImage.swift
//  QuoteGarden-AppClip
//
//  Created by Master Family on 06/02/2021.
//

import SwiftUI

struct GetRect: ViewModifier {

    @Binding var rect: CGRect

    var measureRect: some View {
        GeometryReader { proxy in
            Rectangle().fill(Color.clear)
                .preference(key: RectPreferenceKey.self, value: proxy.frame(in: .global))
        }
    }

    func body(content: Content) -> some View {
        content
            .background(measureRect)
            .onPreferenceChange(RectPreferenceKey.self) { (rect) in
                if let rect = rect {
                    self.rect = rect
                }
            }

    }
}
