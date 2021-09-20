import SwiftUI
import AVFoundation

struct ContentView: View {
  @State private var quote = Quote.help
  @Binding var showingShareSheetView: Bool
  @State private var addedToClipboard = false
  @State private var rect1: CGRect = .zero
  @State private var image: UIImage?
  @State var viewState = CGSize.zero
  let synthesizer: AVSpeechSynthesizer
  var body: some View {
    VStack {
      Color.clear.overlay(
        QuoteView(quote: quote)
          .gesture(
            LongPressGesture().onChanged { _ in
              quote = Quote(id: "", text: "", author: "", genre: "")
              getRandomQuotes { quote in
                self.quote = quote
                addedToClipboard = false
              }
            }
          )
          .animation(.spring())
      ).getRect($rect1)
      .onChange(of: image) { _ in self.image = self.rect1.uiImage }
      .accessibility(addTraits: .isButton)
      .accessibility(label: Text("Change quote"))
      .accessibility(hint: Text("Changes quote when tapped, and display them"))
      HStack {
        Button {
          self.image = self.rect1.uiImage
          if self.image != nil {
            showingShareSheetView = true
          }
        } label: {
          Image(systemName: "square.and.arrow.up")
        }.buttonStyle(IconButtonStyle())
        .accessibilityLabel(Text("Share quote"))
        .accessibility(hint: Text("opens a share sheet view"))
        Button {
          textToSpeech(quote: quote)
        } label: {
          Image(systemName: synthesizer.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
        }.buttonStyle(IconButtonStyle())
        .accessibilityLabel(Text("Quote text to speech"))
        .accessibility(hint: Text("Speak the quote text to your ears"))
        .disabled(synthesizer.isSpeaking)
      }.disabled(quote.text.isEmpty)
    }
    .sheet(isPresented: $showingShareSheetView) {
//      if image != nil {
//        ShareSheetView(activityItems: [
//          self.image!
//        ])
//      }
      #warning("ovo double checkaj")
      if let image = image {
        ShareSheetView(activityItems: [
          image
        ])
      }
    }
  }
  func getRandomQuotes(completion: @escaping (Quote) -> Void) {
    let randomQuote = Int.random(in: 0..<49)
    let url = Bundle.main.url(forResource: "sampleQuotes.json", withExtension: nil)
    URLSession.shared.dataTask(with: url!) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
        print(String(describing: error))
        return
      }
      DispatchQueue.main.async {
        completion(response.data[randomQuote])
      }
      //print(String(data: data, encoding: .utf8)!)
    }
    .resume()
  }
  func textToSpeech(quote: Quote) {
    let utterance = AVSpeechUtterance(string: "\(quote.author) once said, \(quote.text)")
    let voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.voice = voice
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .duckOthers)
      try AVAudioSession.sharedInstance().setActive(true)
      if synthesizer.isSpeaking == false {
        synthesizer.speak(utterance)
      }
    } catch {
      print(error)
    }
  }
}
