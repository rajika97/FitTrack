import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject private var activityVM = DailyActivityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if activityVM.weeklyActivities.isEmpty {
                    Text("No data available.\nStart walking to see your progress!")
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text("Weekly Step Count")
                        .font(.headline)
                    
                    Chart(activityVM.weeklyActivities, id: \.date) { activity in
                        BarMark(
                            x: .value("Date", activity.date!, unit: .day),
                            y: .value("Steps", activity.steps)
                        )
                        .foregroundStyle(.green)
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Text("Distance Trend (meters)")
                        .font(.headline)
                    
                    Chart(activityVM.weeklyActivities, id: \.date) { activity in
                        LineMark(
                            x: .value("Date", activity.date!, unit: .day),
                            y: .value("Distance", activity.distance)
                        )
                        .foregroundStyle(.blue)
                    }
                    .frame(height: 200)
                    .padding()
                }
            }
            .navigationTitle("Statistics")
            .onAppear {
                activityVM.fetchWeeklyActivities()
            }
        }
    }
}

#Preview {
    StatisticsView()
}
