import SwiftUI
import CoreMotion

struct HomeView: View {
    @StateObject private var pedometerVM = PedometerViewModel()
    
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
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
