import XCTest
@testable import FitTrack

final class AchievementsViewModelTests: XCTestCase {
    
    func testFirstStepsAchievementUnlocks() {
        let achievementsVM = AchievementsViewModel()
        achievementsVM.checkForAchievements(stepsToday: 1200, streak: 0, totalDistance: 0)
        
        let unlocked = achievementsVM.achievements.first { $0.title == "First Steps!" }?.isUnlocked
        XCTAssertTrue(unlocked ?? false, "First Steps achievement should unlock at 1000 steps.")
    }
}
