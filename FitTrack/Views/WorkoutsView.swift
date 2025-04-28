import SwiftUI

struct WorkoutsView: View {
    @StateObject private var timerVM = WorkoutTimerViewModel()
    @State private var showingNamePrompt = false
    @State private var workoutName = ""

    
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
                        showingNamePrompt = true
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
                        Text(session.name ?? "Unnamed Session")
                            .font(.headline)
                        
                        if let date = session.date {
                            Text(relativeDateString(for: date))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Text("Duration: \(relativeDurationString(for: session.duration))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(height: 300)

                
                Spacer()
            }
            .padding()
            .onAppear {
                timerVM.fetchSessions()
            }
            .navigationTitle("Workouts")
            .alert("Name Your Workout", isPresented: $showingNamePrompt, actions: {
                TextField("e.g., Morning Run", text: $workoutName)
                Button("Save") {
                    timerVM.saveSession(with: workoutName.isEmpty ? "Unnamed Session" : workoutName)
                    workoutName = ""
                    timerVM.fetchSessions()
                }
                Button("Cancel", role: .cancel) {
                    workoutName = ""
                }
            }, message: {
                Text("Enter a name to identify this workout session.")
            })

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


func relativeDateString(for date: Date) -> String {
    if Calendar.current.isDateInToday(date) {
        return "Today"
    } else if Calendar.current.isDateInYesterday(date) {
        return "Yesterday"
    } else {
        let daysAgo = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        if daysAgo < 7 {
            return "\(daysAgo) days ago"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
    }
}

func relativeDurationString(for duration: TimeInterval) -> String {
    let seconds = Int(duration)
    if seconds < 60 {
        return "\(seconds) sec"
    } else if seconds < 3600 {
        return "\(seconds / 60) min \(seconds % 60) sec"
    } else {
        return "\(seconds / 3600) hr \( (seconds % 3600) / 60 ) min"
    }
}
