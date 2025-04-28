import SwiftUI
import CoreMotion

struct HomeView: View {
    @StateObject private var pedometerVM = PedometerViewModel()
    @StateObject private var activityVM = DailyActivityViewModel()
    @StateObject private var goalVM = GoalViewModel()
    
    @State private var showBadge = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Today's Progress")
                    .font(.title2)
                    .bold()
                
                ProgressRingView(
                    progress: min(Double(pedometerVM.steps) / Double(goalVM.dailyStepGoal), 1.0),
                    stepsText: "\(pedometerVM.steps) / \(goalVM.dailyStepGoal)"
                )
                
                Text(String(format: "Distance: %.2f meters", pedometerVM.distance))
                    .foregroundColor(.gray)
                
                Button("Save Today's Activity") {
                    activityVM.saveTodayActivity(steps: pedometerVM.steps, distance: pedometerVM.distance)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if goalVM.currentStreak > 0 {
                    Text("🔥 Streak: \(goalVM.currentStreak) day\(goalVM.currentStreak > 1 ? "s" : "")")
                        .font(.headline)
                        .foregroundColor(.red)
                        .transition(.opacity)
                }
                
                if showBadge {
                    BadgeView()
                }
                
                Spacer()
            }

            .padding()
            .navigationTitle("Home")
            .onChange(of: pedometerVM.steps) {
                if pedometerVM.steps >= goalVM.dailyStepGoal {
                    withAnimation {
                        showBadge = true
                    }
                    goalVM.updateStreakIfNeeded(currentSteps: pedometerVM.steps)
                }
                
                // Total distance can be fetched from Core Data if needed
                let totalDistance = pedometerVM.distance  // Simplified for now
                
                let achievementsVM = AchievementsViewModel()
                achievementsVM.checkForAchievements(
                    stepsToday: pedometerVM.steps,
                    streak: goalVM.currentStreak,
                    totalDistance: totalDistance
                )
            }

        }
    }
}

#Preview {
    HomeView()
}
