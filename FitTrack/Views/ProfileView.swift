import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personalization")) {
                    NavigationLink(destination: ThemeSettingsView()) {
                        Label("Theme Settings", systemImage: "paintpalette")
                    }
                }
                
                Section(header: Text("Your Progress")) {
                    NavigationLink(destination: AchievementsView()) {
                        Label("Achievements", systemImage: "rosette")
                    }
                }
            }
            .navigationTitle("Profile")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

#Preview {
    ProfileView()
}
