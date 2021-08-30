import SwiftUI

struct BuyStorageView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var storage: Storage
    var body: some View {
        VStack {
            Image("Shop")
                .resizable()
                .scaledToFit()
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
                                storage.amount = 10000
                                
                            }
                        }
                    }
                    
                }
            }
        }
        Button(action: {store.restorePurchases()}) {
            Text("Restore")
        }.buttonStyle(TextButtonStyle())
    }
}

struct BuyStorageView_Previews: PreviewProvider {
    static var previews: some View {
        BuyStorageView()
    }
}
