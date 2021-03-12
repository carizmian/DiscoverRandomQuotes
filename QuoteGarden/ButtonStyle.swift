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
            .foregroundColor(Color("TextColor"))
            .padding(8)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        
    }
}
