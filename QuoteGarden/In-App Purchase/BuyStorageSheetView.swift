//
//  BuyStorageSheetView.swift
//  QuoteGarden
//
//  Created by Master Family on 06/07/2021.
//

import SwiftUI
import Lottie

struct BuyStorageSheetView: View {
    #warning("x-ič u desni vrh kuta da može dismiss sheet")
    @EnvironmentObject var store: Store
    var body: some View {
        VStack {
            VStack {
                LottieView(animationName: "buy")
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(0.2)
            }.padding()
            Text("Save all the quotes you want.")
            List(store.allProducts, id: \.id) { product in
                Group {
                    if !product.isLocked {
                        HStack {
                        ProductRow(product: product) { }
                            Image(systemName: "checkmark")
                                .font(.title3)
                        }
                    } else {
                        ProductRow(product: product) {
                            if let product = store.product(for: product.id) {
                                store.purchaseProduct(product)
                            }
                        }
                    }
                    
                }
            }
        }
        Button(action: {store.restorePurchases()}) {
            Text("Restore")
                .font(.title3)
                .fontWeight(.heavy)
        }.padding(.vertical)
        .padding(.horizontal, 80)
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .foregroundColor(Color("TextColor"))
        .padding(8)
    }
}

//struct BuyStorageSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyStorageSheetView()
//    }
//}
