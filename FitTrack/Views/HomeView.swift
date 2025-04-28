import SwiftUI
import CoreMotion

struct HomeView: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var achievementsVM: AchievementsViewModel

    @StateObject private var pedometerVM = PedometerViewModel()
    @StateObject private var activityVM = DailyActivityViewModel()
    
    @State private var showBadge = false
    @State private var activitySaved = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 🎯 Progress Ring
                    ProgressRingView(
                        progress: min(Double(pedometerVM.steps) / Double(goalVM.dailyStepGoal), 1.0),
                        stepsText: "\(pedometerVM.steps) / \(goalVM.dailyStepGoal)"
                    )
                    .padding(.top, 30)
                    
                    // 📏 Distance Info
                    Text(String(format: "Distance: %.2f meters", pedometerVM.distance))
                        .foregroundColor(.gray)
                    
                    // 🔥 Streak Display
                    if goalVM.currentStreak > 0 {
                        Text("🔥 Streak: \(goalVM.currentStreak) day\(goalVM.currentStreak > 1 ? "s" : "")")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    
                    // 🏅 Goal Achievement Badge
                    if showBadge {
                        BadgeView()
                    }
                    
                    // 🌟 Motivational Quote Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        Text(getMotivationalQuote(steps: pedometerVM.steps, goal: goalVM.dailyStepGoal))
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .frame(height: 100)
                    .transition(.move(edge: .bottom))
                }
                .padding()
            }
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
                    
                    // 🚨 Trigger Achievement Check AFTER Saving
                    achievementsVM.checkForAchievements(
                        stepsToday: pedometerVM.steps,
                        streak: goalVM.currentStreak,
                        totalDistance: pedometerVM.distance  // Ideally sum Core Data for real total
                    )
                    
                    // 🚨 Refresh weekly data for StatisticsView
                    activityVM.fetchWeeklyActivities()
                }
            }

        }
    }
}

func getMotivationalQuote(steps: Int, goal: Int) -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    
    let timeOfDay: String
    switch hour {
        case 5..<12: timeOfDay = "morning"
        case 12..<17: timeOfDay = "afternoon"
        default: timeOfDay = "evening"
    }
    
    let progressRatio = Double(steps) / Double(goal)
    
    if progressRatio >= 1.0 {
        return "🎉 Great job! You've smashed your goal this \(timeOfDay)!"
    } else if progressRatio >= 0.5 {
        return "🔥 Keep going! You're over halfway there!"
    } else {
        return "💪 Let's get moving this \(timeOfDay)! Every step counts!"
    }
}

