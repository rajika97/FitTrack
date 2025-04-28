import SwiftUI
import CoreData

struct WeeklySummaryView: View {
    @StateObject private var activityVM = DailyActivityViewModel()
    
    @State private var totalSteps: Int = 0
    @State private var averageSteps: Int = 0
    @State private var bestDay: String = "N/A"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("📅 Weekly Summary")
                    .font(.largeTitle)
                    .bold()
                
                Text("Total Steps: \(totalSteps)")
                    .font(.title2)
                
                Text("Average Daily Steps: \(averageSteps)")
                    .font(.title3)
                
                Text("Best Day: \(bestDay)")
                    .font(.headline)
                    .foregroundColor(.green)
                
                Spacer()
            }
            .padding()
            .onAppear {
                activityVM.fetchWeeklyActivities()
                calculateSummary()
            }
            .navigationTitle("Summary")
        }
    }
    
    private func calculateSummary() {
        let activities = activityVM.weeklyActivities
        
        guard !activities.isEmpty else { return }
        
        totalSteps = activities.map { Int($0.steps) }.reduce(0, +)
        averageSteps = totalSteps / activities.count
        
        if let best = activities.max(by: { $0.steps < $1.steps }),
           let date = best.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            bestDay = "\(formatter.string(from: date)) - \(best.steps) steps"
        }
    }
}

#Preview {
    WeeklySummaryView()
}
