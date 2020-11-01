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
            .clipShape(Circle())
//            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
//            .overlay(
//                Color.black
//                    .
//                   .opacity(configuration.isPressed ? 0.3 : 0)
//                    .clipShape(Circle())
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
//            )
            .padding()
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        
    }
}
