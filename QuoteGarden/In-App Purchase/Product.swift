import Foundation
import StoreKit

struct Product {
  let id: String
  let title: String
  let description: String
  var isLocked: Bool
  var price: String?
  let locale: Locale
  lazy var formatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = locale
    return numberFormatter
  }()
  init(product: SKProduct, isLocked: Bool = true) {
    self.id = product.productIdentifier
    self.title = product.localizedTitle
    self.description = product.localizedDescription
    self.isLocked = isLocked
    self.locale = product.priceLocale
    if isLocked {
      self.price = formatter.string(from: product.price)
    }
  }
}
