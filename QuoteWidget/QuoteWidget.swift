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

let moc = CoreDataStack.shared.managedObjectContext
let quotesFetch = NSFetchRequest<QuoteCD>(entityName: "QuoteCD")

let userDefaults = UserDefaults.shared


struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: QuoteCD
    
}

//struct Quotes {
//
//    var quotes: [QuoteCD] {
//        do {
//            let quotes = try moc.fetch(request)
//            print("Quotes count \(quotes.count)")
//            return quotes
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//            return [QuoteCD]()
//        }
//    }
//
//}

struct Provider: TimelineProvider {
    
    
    var quotes: [QuoteCD] {
        do {
            let quotes = try moc.fetch(quotesFetch)
            print("Quotes count \(quotes.count)")
            return quotes
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [QuoteCD]()
        }
    }
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), quote: quotes[0] )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: quotes[0])
        completion(entry)
    }
    // Handles updating the widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: quotes[0])
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
                Text("\(entry.quote.quoteText ?? "no")")
                    .italic()
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibilityLabel(Text("quote text is \(entry.quote.quoteText ?? "no")"))
            }.multilineTextAlignment(.center)
            .padding()
            
        default:
            QuoteView(genre: entry.quote.quoteGenre ?? "no", text: entry.quote.quoteText ?? "no", author: entry.quote.quoteAuthor ?? "no")
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
        QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: QuoteCD(context: moc)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
