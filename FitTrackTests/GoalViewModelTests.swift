import XCTest
@testable import FitTrack

final class GoalViewModelTests: XCTestCase {
    
    func testUpdateStreak_FirstTime() {
        // Clear UserDefaults for clean test state
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentStreak")
        defaults.removeObject(forKey: "lastAchievedDate")
        
        let goalVM = GoalViewModel()
        goalVM.currentStreak = 0  // Ensure starting from 0

        // Simulate achieving goal
        goalVM.updateStreakIfNeeded(currentSteps: goalVM.dailyStepGoal + 100)

        XCTAssertEqual(goalVM.currentStreak, 1, "Streak should start at 1 when goal is first achieved.")
    }

    
    func testUpdateStreak_SameDay_NoIncrement() {
        let goalVM = GoalViewModel()
        goalVM.currentStreak = 2
        goalVM.updateStreakIfNeeded(currentSteps: goalVM.dailyStepGoal)
        let initialStreak = goalVM.currentStreak
        
        goalVM.updateStreakIfNeeded(currentSteps: goalVM.dailyStepGoal)
        
        XCTAssertEqual(goalVM.currentStreak, initialStreak, "Streak should not increment twice in one day.")
    }
}
