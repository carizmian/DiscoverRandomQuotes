//
//  ViewModifiers.swift
//  QuoteGarden
//
//  Created by Master Family on 23/10/2020.
//

import SwiftUI


struct CircleButtonViewModifier: ViewModifier {

    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .background(Circle().fill(Color.purple).shadow(radius: 8, x: 4, y: 4))
            .accentColor(.white)
        
    }
}


struct CapsuleButtonViewModifier: ViewModifier {

    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
            .background(Capsule().fill(Color.purple).shadow(radius: 8, x: 4, y: 4))
            .accentColor(.white)
        
    }
}

extension View {
    func customCapsuleButtonStyle() -> some View {
        self.modifier(CapsuleButtonViewModifier())
    }
}

extension View {
    func customCircleButtonStyle() -> some View {
        self.modifier(CircleButtonViewModifier())
    }
}
