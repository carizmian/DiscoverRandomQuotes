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
    
    func makeUIView(context: Context) -> AnimationView{
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
    
    var body: some View {
        VStack {
            
            
            VStack {
                LottieView(animationName: "clock")
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(0.3)

                
                
                
                
                Text("Set daily Spontaneous reminders.")
                    .font(.headline)
                
            }.padding()
            
            Form {
                
                HStack {
                    Text("Remind me")
                    Stepper(value: $reminderFrequency, in: 3...16, step: 1.0) {
                        Text("\(reminderFrequency, specifier: "%g") times")
                    }
                    
                }
                DatePicker(selection: $reminderStartTime, displayedComponents: .hourAndMinute) {
                    Text("Start at")
                }
                DatePicker(selection: $reminderEndTime, displayedComponents: .hourAndMinute) {
                    Text("End at")
                }
                
            }
            Button(action: {setNotification()}, label: {
                Text("Continue")
                    .font(.title3)
                    .fontWeight(.black)
            }).padding(.vertical)
            .padding(.horizontal, 100.0)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(Color("TextColor"))
            .padding(8)
//            Button(action: {UNUserNotificationCenter.current().removeAllPendingNotificationRequests()}, label: {
//                Text("Cancel All")
//            })
        }
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
            manager.addNotification(title: "This is a test reminder", body: "This is the body", dateComponents: dateComponents)
        }
        
        manager.schedule()
        
    }
}

struct ReminderOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderOnboardingView()
    }
}


