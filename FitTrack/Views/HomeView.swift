import SwiftUI
import CoreMotion

struct HomeView: View {
    @StateObject private var pedometerVM = PedometerViewModel()
    @StateObject private var activityVM = DailyActivityViewModel()
    @StateObject private var goalVM = GoalViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Today's Steps")
                    .font(.title2)
                    .bold()
                
                Text("\(pedometerVM.steps) / \(goalVM.dailyStepGoal)")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(pedometerVM.steps >= goalVM.dailyStepGoal ? .green : .orange)
                
                ProgressView(value: Float(pedometerVM.steps), total: Float(goalVM.dailyStepGoal))
                    .padding()
                
                Text(String(format: "Distance: %.2f meters", pedometerVM.distance))
                    .foregroundColor(.gray)
                
                Button("Save Today's Activity") {
                    activityVM.saveTodayActivity(steps: pedometerVM.steps, distance: pedometerVM.distance)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
