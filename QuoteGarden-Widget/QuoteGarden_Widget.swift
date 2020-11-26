//
//  QuoteGarden_Widget.swift
//  QuoteGarden-Widget
//
//  Created by Master Family on 18/11/2020.
//

import WidgetKit
import SwiftUI

struct QuoteGardenEntry: TimelineEntry {
    let date: Date = Date()
    let quote: Quote
}

struct Provider: TimelineProvider {
    @AppStorage("primaryQuote", store: UserDefaults(suiteName: "group.com.example.QuoteGarden")) var primaryQuoteData: Data = Data()
    
    func placeholder(in context: Context) -> QuoteGardenEntry {
        let quote = Quote(id: "", quoteText: "Your favorite quote can be displayed here", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
        return QuoteGardenEntry(quote: quote)
        
    }
    
    func getSnapshot(in context: Context, completion: @escaping (QuoteGardenEntry) -> Void) {
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: primaryQuoteData) else {
            print("Unable to decode primary quote")
           return
        }
        let entry = QuoteGardenEntry(quote: quote)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: primaryQuoteData) else {
            print("Unable to decode primary quote")
           return
        }
        let entry = QuoteGardenEntry(quote: quote)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: View
struct QuoteGardenWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        if family == .systemMedium {
            MediumWidget(entry: entry)
        } else {
            LargeWidget(entry: entry)
        }
    }
}

struct MediumWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("\(entry.quote.quoteText)")
                .italic()
                .font(Font.system(.title, design: .monospaced).weight(.black))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))

        }.multilineTextAlignment(.center)
        .padding()
    }
}

struct LargeWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {

            HStack {
                Text("#")
                    .foregroundColor(.green)
                Text("\(entry.quote.quoteGenre)")
            }.padding(.bottom)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .monospaced).weight(.bold))
            .accessibilityLabel(Text("quote genre is hashtag \(entry.quote.quoteGenre)"))

            Text("\(entry.quote.quoteText)")
                .italic()
                .font(Font.system(.title, design: .monospaced).weight(.black))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))

            HStack {
                Text("~")
                    .foregroundColor(.green)
                Text("\(entry.quote.quoteAuthor)")

            }.padding(.top)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .monospaced).weight(.bold))
            .accessibilityLabel(Text("quote author is \(entry.quote.quoteAuthor)"))

        }.multilineTextAlignment(.center)
        .padding()
    }
}

@main
struct QuoteGardenWidget: Widget {
    let kind: String = "QuoteGarden_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuoteGardenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Spontaneous - Random quotes")
        .description("These are the Widgets which display a quote.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct QuoteGardenWidge_Previews: PreviewProvider {
    static let quote = Quote(id: "", quoteText: "Your favorite quote can be displayed here", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
    static var previews: some View {
        QuoteGardenWidgetEntryView(entry: QuoteGardenEntry(quote: quote))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
