//
//  ContentView.swift
//  QuoteGarden-Watch Extension
//
//  Created by Master Family on 05/12/2020.
//

import SwiftUI


struct ContentView: View {
    // TODO: WatchOS app can generate new quotes and that is it (user muzst be connected to the internet maybe try fixing this by downloading quotes on the watch)
    @State private var quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
    @State var viewState = CGSize.zero
    
    
    var body: some View {
        QuoteView(quote: quote)
            .gesture(
                LongPressGesture().onChanged { _ in
                    
                    QuoteGardenApi().getRandomQuote { quote in
                        
                        self.quote = quote
                        
                    }
                }
            )
            .offset(x: viewState.width, y: viewState.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        viewState = value.translation
                    }
                    .onEnded { _ in
                        viewState = .zero
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
