import SwiftUI

@main
struct FitTrackApp: App {
    @StateObject var theme = ThemeManager.shared
    @StateObject var goalVM = GoalViewModel()
    @StateObject var achievementsVM = AchievementsViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(theme)
                .environmentObject(goalVM)
                .environmentObject(achievementsVM)
                .accentColor(theme.selectedColor)
                .preferredColorScheme(theme.selectedMode)
        }
    }
}
