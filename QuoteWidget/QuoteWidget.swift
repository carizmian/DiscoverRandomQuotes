//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Master Family on 20/10/2020.
//

import WidgetKit
import SwiftUI
import CoreData

// TODO: Implementation from WWDC 2'nd video


let userDefaults = UserDefaults.shared
struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: WidgetQuote

}

struct WidgetQuote {
    let genre = userDefaults.string(forKey: "genre") ?? ""
    let text = userDefaults.string(forKey: "text") ?? "Please select a  quote to display here"
    let author = userDefaults.string(forKey: "author") ?? ""
}

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), quote: WidgetQuote() )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: WidgetQuote())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: WidgetQuote())
        let timeline = Timeline(entries: [entry], policy: .never)
        // never jer nemamo array of entry
        completion(timeline)
    }
}

struct QuoteWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {

        switch family {
        case .systemMedium:

            VStack(alignment: .center) {
                Text("\(entry.quote.text)")
                    .italic()
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibilityLabel(Text("quote text is \(entry.quote.text)"))
            }.multilineTextAlignment(.center)
            .padding()

        default:
            QuoteView(genre: entry.quote.genre, text: entry.quote.text, author: entry.quote.author)
        }

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
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct QuoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: WidgetQuote()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
