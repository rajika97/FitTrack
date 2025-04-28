import SwiftUI

@main
struct FitTrackApp: App {
    @StateObject var theme = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(theme.selectedColor)
                .preferredColorScheme(theme.selectedMode)
        }
    }
}
