import Foundation
import AVFoundation

class SpeechManager: ObservableObject {
  static let synth = AVSpeechSynthesizer()
  static let shared = SpeechManager()
  @Published var isSpeaking = false
  init() {
    print("initialising SpeechManager with \(SpeechManager.synth.description)")
  }
}
extension SpeechManager {
  func textToSpeech(quote: Quote) {
    if SpeechManager.synth.isPaused {
      SpeechManager.synth.continueSpeaking()
      isSpeaking = true
    } else if SpeechManager.synth.isSpeaking {
      SpeechManager.synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
      isSpeaking = false
    } else if !SpeechManager.synth.isSpeaking {
      let utterance = AVSpeechUtterance(string: "\(quote.author) once said, \(quote.text)")
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
      utterance.rate = 0.4
      SpeechManager.synth.speak(utterance)
      isSpeaking = true
    }
  }
}
extension SpeechManager {
  func resetState() {
    SpeechManager.synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    isSpeaking = false
  }
}
