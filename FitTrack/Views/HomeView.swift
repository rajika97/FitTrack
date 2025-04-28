import SwiftUI
import CoreMotion

struct HomeView: View {
    @StateObject private var pedometerVM = PedometerViewModel()
    @StateObject private var activityVM = DailyActivityViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Today's Steps")
                    .font(.title2)
                    .bold()
                
                Text("\(pedometerVM.steps)")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundColor(.green)
                
                Text(String(format: "Distance: %.2f meters", pedometerVM.distance))
                    .foregroundColor(.gray)
                
                Button("Save Today's Activity") {
                    activityVM.saveTodayActivity(steps: pedometerVM.steps, distance: pedometerVM.distance)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
