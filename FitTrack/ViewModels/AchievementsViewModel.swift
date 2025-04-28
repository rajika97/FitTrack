import Foundation

class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []
    
    init() {
        loadAchievements()
    }
    
    func loadAchievements() {
        achievements = [
            Achievement(title: "First Steps!", description: "Walk 1,000 steps in a day", icon: "🥾", isUnlocked: getStatus(for: "firstSteps")),
            Achievement(title: "10K Champ", description: "Walk 10,000 steps in a day", icon: "🏅", isUnlocked: getStatus(for: "10kChamp")),
            Achievement(title: "Streak Master", description: "7-day streak", icon: "🔥", isUnlocked: getStatus(for: "streakMaster")),
            Achievement(title: "Marathoner", description: "Reach 42 KM total", icon: "🎖️", isUnlocked: getStatus(for: "marathoner"))
        ]
    }
    
    private func getStatus(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func unlock(_ key: String) {
        UserDefaults.standard.set(true, forKey: key)
        loadAchievements()
    }
    
    // Call this function to check conditions
    func checkForAchievements(stepsToday: Int, streak: Int, totalDistance: Double) {
        if stepsToday >= 1000 { unlock("firstSteps") }
        if stepsToday >= 10000 { unlock("10kChamp") }
        if streak >= 7 { unlock("streakMaster") }
        if totalDistance >= 42000 { unlock("marathoner") }  // Distance in meters
    }
}
