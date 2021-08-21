import SwiftUI

struct QuoteView: View {

    var quote: Quote

    var body: some View {

        #if os(iOS)
            VStack(alignment: .center) {

                HStack {
                    Text("#")
                    Text("\(quote.quoteGenre)")
                }.padding(.bottom)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .rounded).weight(.light))
                .accessibility(value: Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .font(Font.system(.title, design: .rounded).weight(.light))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))

                HStack {
                    Text("~")
                    Text("\(quote.quoteAuthor)")

                }.padding(.top)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .rounded).weight(.light))
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

            }.foregroundColor(Color("TextColor"))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color("AccentColor").clipShape(RoundedRectangle(cornerRadius: 25)))
        #elseif os(watchOS)
        VStack(alignment: .leading) {

                Text("\(quote.quoteText)")
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.1)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))
                HStack {
                    Text("~")
                    Text("\(quote.quoteAuthor)")

                }.padding(.top, 1)
                .allowsTightening(true)
                .font(.body)
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

        }.multilineTextAlignment(.leading)
        .edgesIgnoringSafeArea(.all)
        #endif
        
    }
}

struct QuoteView_Previews: PreviewProvider {
    static let quote = Quote(id: "", quoteText: "I don't believe you have to be better than everybody else. I believe you have to be better than you ever thought you could be.", quoteAuthor: "Ken Venturi", quoteGenre: "motivation")
    
    static var previews: some View {
        Group {
            QuoteView(quote: quote)
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .extraLarge)
            
            QuoteView(quote: quote)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
