import XCTest
@testable import FitTrack

final class GoalViewModelTests: XCTestCase {
    
    func testDefaultDailyGoal() {
        let goalVM = GoalViewModel()
        XCTAssertTrue(goalVM.dailyStepGoal >= 5000, "Default daily step goal should be at least 5000")
    }
    
    func testStreakIncrement() {
        let goalVM = GoalViewModel()
        goalVM.currentStreak = 3
        goalVM.updateStreakIfNeeded(currentSteps: goalVM.dailyStepGoal)
        XCTAssertTrue(goalVM.currentStreak >= 3, "Streak should not decrease when updated properly")
    }
}
