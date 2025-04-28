import Foundation

class GoalViewModel: ObservableObject {
    @Published var dailyStepGoal: Int {
        didSet {
            UserDefaults.standard.set(dailyStepGoal, forKey: "dailyStepGoal")
        }
    }
    
    @Published var currentStreak: Int {
        didSet {
            UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        }
    }
    
    private var lastAchievedDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "lastAchievedDate") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastAchievedDate")
        }
    }
    
    init() {
        let savedGoal = UserDefaults.standard.integer(forKey: "dailyStepGoal")
        self.dailyStepGoal = savedGoal == 0 ? 5000 : savedGoal  // Default goal if none set
        
        self.currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
    }
    
    /// Call this when steps are updated to check if streak should be incremented
    func updateStreakIfNeeded(currentSteps: Int) {
        let today = Calendar.current.startOfDay(for: Date())
        
        guard currentSteps >= dailyStepGoal else {
            return  // Goal not yet reached today
        }
        
        if let lastDate = lastAchievedDate {
            if Calendar.current.isDateInToday(lastDate) {
                // Already counted today's achievement
                return
            } else if Calendar.current.isDate(lastDate, equalTo: today.addingTimeInterval(-86400), toGranularity: .day) {
                // Goal achieved on consecutive day
                currentStreak += 1
            } else {
                // Missed a day, reset streak
                currentStreak = 1
            }
        } else {
            // First time achieving goal
            currentStreak = 1
        }
        
        lastAchievedDate = today
    }
}
