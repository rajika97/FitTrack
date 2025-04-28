import SwiftUI

struct ThemeSettingsView: View {
    @ObservedObject var theme = ThemeManager.shared
    
    var body: some View {
        Form {
            Section(header: Text("Accent Color")) {
                HStack {
                    ColorButton(color: .blue, name: "blue")
                    ColorButton(color: .green, name: "green")
                    ColorButton(color: .red, name: "red")
                    ColorButton(color: .purple, name: "purple")
                }
            }
            
            Section(header: Text("Appearance Mode")) {
                Picker("Mode", selection: Binding(
                    get: {
                        theme.selectedMode == nil ? "system" : (theme.selectedMode == .dark ? "dark" : "light")
                    },
                    set: { theme.updateColorScheme(to: $0) }
                )) {
                    Text("System Default").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Theme Settings")
    }
    
    @ViewBuilder
    func ColorButton(color: Color, name: String) -> some View {
        Circle()
            .fill(color)
            .frame(width: 30, height: 30)
            .overlay(
                Circle().stroke(theme.selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
            )
            .onTapGesture {
                theme.updateAccentColor(to: color, name: name)
            }
    }
}

#Preview {
    ThemeSettingsView()
}
