import Foundation

class GoalViewModel: ObservableObject {
    @Published var dailyStepGoal: Int {
        didSet {
            UserDefaults.standard.set(dailyStepGoal, forKey: "dailyStepGoal")
        }
    }
    
    init() {
        self.dailyStepGoal = UserDefaults.standard.integer(forKey: "dailyStepGoal")
        if self.dailyStepGoal == 0 {
            self.dailyStepGoal = 5000  // Default goal
        }
    }
}
