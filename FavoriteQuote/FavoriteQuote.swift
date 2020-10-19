//
//  FavoriteQuote.swift
//  FavoriteQuote
//
//  Created by Master Family on 13/10/2020.
//

import WidgetKit
import SwiftUI
import Intents



struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    
    //TODO
    #warning("populate the views with this data below!")
    
    let quoteGenre = UserDefaults(suiteName: "group.com.example.QuoteGarden")!.string(forKey: "genre")
    let quoteText = UserDefaults(suiteName: "group.com.example.QuoteGarden")!.string(forKey: "text")
    let quoteAuthore = UserDefaults(suiteName: "group.com.example.QuoteGarden")!.string(forKey: "author")
}

struct PlaceholderView: View {
    var body: some View {
        QuoteView(quoteGenre: "finance", quoteText: "What gets measured gets managed", quoteAuthor: "Peter Drucker")
    }
}


struct FavoriteQuoteEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        QuoteView(quoteGenre: "finance", quoteText: "What gets measured gets managed", quoteAuthor: "Peter Drucker")
    }
}

@main
struct FavoriteQuote: Widget {
    let kind: String = "FavoriteQuote"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            FavoriteQuoteEntryView(entry: entry)
        }
        .configurationDisplayName("Favorite Quote")
        .description("Look at your favorite quote")
        .supportedFamilies([.systemLarge])
    }
}

struct FavoriteQuote_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            QuoteView(quoteGenre: "finance", quoteText: "What gets measured gets managed", quoteAuthor: "Peter Drucker")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

