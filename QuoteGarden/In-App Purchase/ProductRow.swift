//
//  ProductRow.swift
//  QuoteGarden
//
//  Created by Master Family on 06/07/2021.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let action : () -> Void
    @State private var startAnimation = false
    var body: some View {
        HStack {
            VStack {
                Text(product.title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Spacer()
            if let price = product.price, product.isLocked {
                Button(action: action) {
                    HStack {
                        Text(price)
                        Image(systemName: "cart.fill")
                            .overlay(
                                Image(systemName: "cart.fill")
                                    .scaleEffect(startAnimation ? 1.1 : 1)
                                    .opacity(startAnimation ? 0 : 1))
                            .rotationEffect(Angle(degrees:startAnimation ? 360 : 0))
                            .animation(Animation.easeOut(duration: 0.6)
                                        .delay(3)
                                        .repeatForever(autoreverses: false))
                    }.padding(8)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(Color("TextColor"))
                }
            }
        }.onAppear {
            startAnimation.toggle()
        }
    }
}
