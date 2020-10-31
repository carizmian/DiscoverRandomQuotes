//
//  ButtonStyle.swift
//  QuoteGarden
//
//  Created by Master Family on 26/10/2020.
//

import SwiftUI

struct ColoredButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .padding()
    }
}
