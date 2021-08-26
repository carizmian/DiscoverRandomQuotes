import SwiftUI
import Lottie

struct ReminderView: View {
    // Toggle work great with .onChange
    @State private var sendReminders = true
    @State private var reminderFrequency = 3.0
    @ObservedObject var manager = NotificationManager.shared
    var body: some View {
        VStack {
            
            Toggle("Send Reminders", isOn: $sendReminders)
                .onDisappear {
                    switch sendReminders {
                    case true: do {
                        manager.addNotifications(reminderFrequency: reminderFrequency)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            manager.setNotifications()
                            print("setting notifications")
                        }
                    }
                    case false: do {
                        manager.center.removeAllPendingNotificationRequests()
                    }
                    }
                }
            VStack {
                LottieView(animationName: "countdown")
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(0.4)
            }.padding()
            VStack {
                Text("Get Quotes reminders.")
                    .multilineTextAlignment(.center)
                
                Stepper(value: $reminderFrequency, in: 3...7) {
                    Text("Every \(reminderFrequency, specifier: "%.f") hours.")
                        .fontWeight(.semibold)
                }.padding()
                
            }
            
        }.padding(.horizontal)
        .edgesIgnoringSafeArea(.top)        
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
