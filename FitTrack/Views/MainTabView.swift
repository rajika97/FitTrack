import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            WorkoutsView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Workouts")
                }
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
            
            GoalsView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
            
            AchievementsView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Achievements")
                }

        }
    }
}

#Preview {
    MainTabView()
}
