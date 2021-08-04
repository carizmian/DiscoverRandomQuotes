//
//  ReminderOnboardingView.swift
//  QuoteGarden
//
//  Created by Master Family on 18/03/2021.
//

import SwiftUI
import Lottie

extension Double {
    func toInt() -> Int {
        Int(self)
    }
}

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

struct ReminderOnboardingView: View {
    @State private var reminderFrequency = 13.0
    @State private var reminderStartTime = Date(timeIntervalSince1970: TimeInterval(7*60*60))
    @State private var reminderEndTime = Date(timeIntervalSince1970: TimeInterval(19*60*60))
    let manager = LocalNotificationManager()
    @Binding var showOnboarding: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        showOnboarding.toggle()
                    
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.vertical)
                        .font(.largeTitle)
                })
                
            }
            VStack {
                LottieView(animationName: "countdown")
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(0.4)
            }.padding()
            
            //  Form {
            VStack {
                Text("Set daily Spontaneous reminders.")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Remind me")
                        .fontWeight(.bold)
                    Stepper(value: $reminderFrequency, in: 3...16, step: 1.0) {
                        Text("\(reminderFrequency, specifier: "%g") times")
                            .fontWeight(.bold)
                    }
                    
                }
                DatePicker(selection: $reminderStartTime, displayedComponents: .hourAndMinute) {
                    Text("Start at")
                        .fontWeight(.bold)
                }
                DatePicker(selection: $reminderEndTime, displayedComponents: .hourAndMinute) {
                    Text("End at")
                        .fontWeight(.bold)
                }
                
            }
            Spacer()
            Button(action: {setNotification()}, label: {
                Text("Continue")
                    .font(.title3)
                    .fontWeight(.heavy)
            }).padding(.vertical)
            .padding(.horizontal, 80)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .foregroundColor(Color("TextColor"))
            .padding(8)

        }.padding(.horizontal)
        .edgesIgnoringSafeArea(.top)
            
    }
    
    func setNotification() {
        
        let firstDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderStartTime)
        let lastDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderEndTime)
        
        var dateComponentsArray = [firstDateComponents, lastDateComponents]
        
        for _ in 1...reminderFrequency.toInt()-2 {
            
            let hour = Int.random(in: firstDateComponents.hour!-1..<lastDateComponents.hour!-1 )
            let minute = Int.random(in: 0...59)
            
            let date = Date(timeIntervalSince1970: TimeInterval(hour*60*60 + minute*60))
            
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: date)
            print("hour: \(String(describing: dateComponent.hour)) minute: \(String(describing: dateComponent.minute))")
            
            dateComponentsArray.append(dateComponent)
        }
        for dateComponents in dateComponentsArray {
            
            getRandomQuote { quote in
                manager.addNotification(title: quote.quoteAuthor, body: quote.quoteText, dateComponents: dateComponents)
                
                print(quote.id)
                
            }
            
        }
     //   showingAlert.toggle()
        manager.schedule()
        showOnboarding.toggle()
        
      //  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
}

//struct ReminderOnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ReminderOnboardingView()
//            //  .previewLayout(.sizeThatFits)
//            ReminderOnboardingView()
//                .preferredColorScheme(.dark)
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
