import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
    
    var animationName: String
    
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: animationName, bundle: Bundle.main)
        view.loopMode = .loop
        view.play()
        
        return view
    }
}
