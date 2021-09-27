import SwiftUI

struct QuoteView: View {
  var quote: Quote
  var body: some View {
    #if os(iOS)
    VStack(alignment: .center) {
      Text("#\(quote.genre)")
        .padding(.bottom)
        .allowsTightening(true)
        .font(Font.system(.caption, design: .default).weight(.light))
        .accessibility(value: Text("quote genre is hashtag \(quote.genre)"))
      Text("\(quote.text)")
        .font(Font.system(.title, design: .default).weight(.light))
        .padding(.horizontal)
        .allowsTightening(true)
        .layoutPriority(2)
        .minimumScaleFactor(0.3)
        .accessibility(value: Text("quote text is \(quote.text)"))
      Text("\(quote.author)")
        .padding(.top)
        .allowsTightening(true)
        .font(Font.system(.callout, design: .default).weight(.regular))
        .accessibility(value: Text("quote author is \(quote.author)"))
    }.foregroundColor(Color("TextColor"))
    .multilineTextAlignment(.center)
    .padding()
    .background(Color("AccentColor").clipShape(RoundedRectangle(cornerRadius: 25)))
    .padding()
    #elseif os(watchOS)
    VStack(alignment: .leading) {
      Text("\(quote.text)")
        .allowsTightening(true)
        .layoutPriority(2)
        .minimumScaleFactor(0.1)
        .accessibility(value: Text("quote text is \(quote.text)"))
      HStack {
        Text("~")
        Text("\(quote.author)")
      }.padding(.top, 1)
      .allowsTightening(true)
      .font(.body)
      .accessibility(value: Text("quote author is \(quote.author)"))
    }.multilineTextAlignment(.leading)
    .edgesIgnoringSafeArea(.all)
    #endif
  }
}

//struct QuoteView_Previews: PreviewProvider {
//  static let quote = Quote(id: "", text: "I don't believe you have to be better than everybody else. I believe you have to be better than you ever thought you could be.", author: "Ken Venturi", genre: "motivation")
//  static var previews: some View {
//    Group {
//      QuoteView(quote: quote)
//        .previewLayout(.sizeThatFits)
//        .environment(\.sizeCategory, .extraLarge)
//      QuoteView(quote: quote)
//        .preferredColorScheme(.dark)
//        .previewLayout(.sizeThatFits)
//    }
//  }
//}
