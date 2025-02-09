import SwiftUI

struct BuyStorageSheetView: View {
  @EnvironmentObject var store: Store
  @EnvironmentObject var storage: Storage
  @Binding var showBuying: Bool
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button { showBuying.toggle() } label: {
          Image(systemName: "xmark")
        }.buttonStyle(IconButtonStyle())
      }
      Image("Shop")
        .resizable()
        .scaledToFit()
      Text(LocalizedStringKey("buy.header"))
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
  }
}
