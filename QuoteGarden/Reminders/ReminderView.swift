import SwiftUI
import Lottie

struct ReminderView: View {
    @State private var sendReminders = true
    @EnvironmentObject var manager: LocalNotificationManager
    var body: some View {
        VStack {
            
            Toggle("Send Reminders", isOn: $sendReminders)
                .onDisappear {
                    switch sendReminders {
                    case true: do {
                        manager.addNotifications()
                        #warning("First add notification to notification array, second schedule the notifications")
                        #warning("simply add a loading screen to load the quotes")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            manager.scheduleNotifications()
                            print("seting notifications")
                        }
                    }
                    case false: do {
                        manager.removeAllNotifications()
                        print("removed pending notifications")
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
                Text("Set daily Quotes reminders.")
                    .multilineTextAlignment(.center)
                
            }
            
        }.padding(.horizontal)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            manager.removeAllNotifications()
        }
        
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
