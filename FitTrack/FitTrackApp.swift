import SwiftUI

@main
struct FitTrackApp: App {
    @StateObject var theme = ThemeManager.shared
    @StateObject var goalVM = GoalViewModel()   // Shared GoalViewModel

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(theme)
                .environmentObject(goalVM)   // Inject here
                .accentColor(theme.selectedColor)
                .preferredColorScheme(theme.selectedMode)
        }
    }
}
