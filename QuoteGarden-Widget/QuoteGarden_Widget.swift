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
                .font(Font.system(.title, design: .rounded).weight(.light))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))
            
        }.padding()
        .multilineTextAlignment(.center)
        
    }
}

struct LargeWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Text("#")
                Text("\(entry.quote.quoteGenre)")
            }.padding(.bottom)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .rounded).weight(.light))
            .accessibilityLabel(Text("quote genre is hashtag \(entry.quote.quoteGenre)"))
            
            Text("\(entry.quote.quoteText)")
                .font(Font.system(.title, design: .rounded).weight(.light))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))
            
            HStack {
                Text("~")
                Text("\(entry.quote.quoteAuthor)")
                
            }.padding(.top)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .rounded).weight(.light))
            .accessibilityLabel(Text("quote author is \(entry.quote.quoteAuthor)"))
            
        }.padding()
        .multilineTextAlignment(.center)
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
    static let quote = Quote(id: "", quoteText: "I don't believe you have to be better than everybody else. I believe you have to be better than you ever thought you could be.", quoteAuthor: "Ken Venturi", quoteGenre: "motivation")
    static var previews: some View {
        Group {
            QuoteGardenWidgetEntryView(entry: QuoteGardenEntry(quote: quote))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewLayout(.sizeThatFits)
            
            QuoteGardenWidgetEntryView(entry: QuoteGardenEntry(quote: quote))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewLayout(.sizeThatFits)
        }
    }
}
