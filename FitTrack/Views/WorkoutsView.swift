import SwiftUI

struct WorkoutsView: View {
    @StateObject private var timerVM = WorkoutTimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Divider()
                Text(formatTime(timerVM.elapsedTime))
                    .font(.system(size: 50))
                    .monospacedDigit()
                
                if timerVM.isRunning {
                    Button("Stop Workout") {
                        timerVM.stopTimer()
                        timerVM.fetchSessions()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Button("Start Workout") {
                        timerVM.startTimer()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Divider()
                
                Text("Past Sessions")
                    .font(.headline)
                
                List(timerVM.pastSessions, id: \.self) { session in
                    VStack(alignment: .leading) {
                        Text(session.date ?? Date(), style: .date)
                        Text("Duration: \(formatTime(session.duration))")
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: 200)
                
                Spacer()
            }
            .padding()
            .onAppear {
                timerVM.fetchSessions()
            }
            .navigationTitle("Workouts")
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    WorkoutsView()
}
