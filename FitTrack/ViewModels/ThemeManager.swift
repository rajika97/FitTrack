import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var selectedColor: Color
    @Published var selectedMode: ColorScheme?
    
    private init() {
        let colorName = UserDefaults.standard.string(forKey: "accentColor") ?? "blue"
        selectedColor = ThemeManager.colorFromName(colorName)
        
        let modeRaw = UserDefaults.standard.string(forKey: "colorScheme") ?? "system"
        selectedMode = ThemeManager.schemeFromString(modeRaw)
    }
    
    func updateAccentColor(to color: Color, name: String) {
        selectedColor = color
        UserDefaults.standard.set(name, forKey: "accentColor")
    }
    
    func updateColorScheme(to mode: String) {
        selectedMode = ThemeManager.schemeFromString(mode)
        UserDefaults.standard.set(mode, forKey: "colorScheme")
    }
    
    private static func colorFromName(_ name: String) -> Color {
        switch name {
            case "green": return .green
            case "red": return .red
            case "purple": return .purple
            default: return .blue
        }
    }
    
    private static func schemeFromString(_ str: String) -> ColorScheme? {
        switch str {
            case "light": return .light
            case "dark": return .dark
            default: return nil  // System default
        }
    }
}
