import Foundation
import AVFoundation

enum SpeechSynthesizer {
  static let shared = AVSpeechSynthesizer()
}

extension AVSpeechSynthesizer {
  func textToSpeech(quote: Quote) {
    if self.isPaused {
      self.continueSpeaking()
    } else if self.isSpeaking {
      self.pauseSpeaking(at: AVSpeechBoundary.immediate)
    } else if !self.isSpeaking {
      let utterance = AVSpeechUtterance(string: "\(quote.author) once said, \(quote.text)")
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
      utterance.rate = 0.4
      self.speak(utterance)
    }
  }
}
