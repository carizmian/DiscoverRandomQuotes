import Foundation

class Storage: ObservableObject {
  var amount: Int = 3
  init() {
    print("initialising Storage")
  }
}
