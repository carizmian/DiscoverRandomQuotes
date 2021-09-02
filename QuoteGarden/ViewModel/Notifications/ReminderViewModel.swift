import Foundation

class ReminderViewModel: ObservableObject {
    @Published var sendReminders: Bool = UserDefaults.standard.bool(forKey: "sendReminders") {
        didSet {
            UserDefaults.standard.set(sendReminders, forKey: "sendReminders")
            print("setting sendReminders - \(sendReminders) - UserDefaults")
        }
    }
    @Published var reminderFrequency: Double = UserDefaults.standard.double(forKey: "reminderFrequency") {
        didSet {
            UserDefaults.standard.set(reminderFrequency, forKey: "reminderFrequency")
            print("setting reminderFrequency - \(reminderFrequency) - UserDefaults")
        }
    }
}
