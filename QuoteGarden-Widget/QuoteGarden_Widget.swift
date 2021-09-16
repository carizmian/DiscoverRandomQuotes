import WidgetKit
import SwiftUI

struct QuoteGardenEntry: TimelineEntry {
  let date = Date()
  let quote: Quote
}

struct Provider: TimelineProvider {
  @AppStorage("primaryQuote", store: UserDefaults(suiteName: "group.com.example.QuoteGarden")) var primaryQuoteData = Data()
  func placeholder(in context: Context) -> QuoteGardenEntry {
    let quote = Quote.example
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
      Text("\(entry.quote.text)")
        .font(Font.system(.title, design: .default).weight(.light))
        .padding(.horizontal)
        .allowsTightening(true)
        .layoutPriority(2)
        .minimumScaleFactor(0.3)
        .accessibilityLabel(Text("quote text is \(entry.quote.text)"))
    }.padding()
    .multilineTextAlignment(.center)
  }
}

struct LargeWidget: View {
  var entry: Provider.Entry
  var body: some View {
    VStack(alignment: .center) {
      Text("#\(entry.quote.genre)")
        .padding(.bottom)
        .allowsTightening(true)
        .font(Font.system(.caption, design: .default).weight(.light))
        .accessibilityLabel(Text("quote genre is hashtag \(entry.quote.genre)"))
      Text("\(entry.quote.text)")
        .font(Font.system(.title, design: .default).weight(.light))
        .padding(.horizontal)
        .allowsTightening(true)
        .layoutPriority(2)
        .minimumScaleFactor(0.3)
        .accessibilityLabel(Text("quote text is \(entry.quote.text)"))
      Text("\(entry.quote.author)")
        .padding(.top)
        .allowsTightening(true)
        .font(Font.system(.callout, design: .default).weight(.regular))
        .accessibilityLabel(Text("quote author is \(entry.quote.author)"))
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
  static let quote = Quote.example
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
