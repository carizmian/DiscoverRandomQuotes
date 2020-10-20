//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Master Family on 20/10/2020.
//

import WidgetKit
import SwiftUI

let userDefaults = UserDefaults.init(suiteName: "group.com.example.QuoteGarden")

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: WidgetQuote() )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: WidgetQuote())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: WidgetQuote())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: WidgetQuote
    
}

struct WidgetQuote {
    
    let genre = userDefaults?.string(forKey: "genre") ?? "not set"
    let text = userDefaults?.string(forKey: "text") ?? "not set"
    let author = userDefaults?.string(forKey: "author") ?? "not set"
    
    
    
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
        .configurationDisplayName("Favorite quote")
        .description("See your favorite quote in a widget.")
    }
}

struct QuoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: WidgetQuote()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
