import SwiftUI
import CoreMotion

struct HomeView: View {
    @StateObject private var pedometerVM = PedometerViewModel()
    @StateObject private var activityVM = DailyActivityViewModel()
    @StateObject private var goalVM = GoalViewModel()
    @State private var activitySaved = false
    
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
                
                if !activitySaved {
                    activityVM.saveTodayActivity(steps: pedometerVM.steps, distance: pedometerVM.distance)
                    activitySaved = true
                }
            }

        }
    }
}

#Preview {
    HomeView()
}
