//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Master Family on 20/10/2020.
//

import WidgetKit
import SwiftUI

let userDefaults = UserDefaults(suiteName: "group.com.example.QuoteGarden")
#warning("user more birat koji ce citat stavit kada stvara widget")

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: WidgetQuote
    
}

struct WidgetQuote {
    let genre = userDefaults?.string(forKey: "genre") ?? "not set"
    let text = userDefaults?.string(forKey: "text") ?? "not set"
    let author = userDefaults?.string(forKey: "author") ?? "not set"
}


struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), quote: WidgetQuote() )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: WidgetQuote())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: WidgetQuote())
        let timeline = Timeline(entries: [entry], policy: .never)
        // never jer nemamo array of entry
        completion(timeline)
    }
}


struct QuoteWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        QuoteView(quoteGenre: entry.quote.genre, quoteText: entry.quote.text, quoteAuthor: entry.quote.author)
    }
}

@main
struct QuoteWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Your favorite quote")
        .description("Read your favorite quote on your homescreen.")
        .supportedFamilies([.systemLarge])
    }
}

struct QuoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: WidgetQuote()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
