import SwiftUI

struct GoalsView: View {
    @StateObject private var goalVM = GoalViewModel()
    @State private var newGoal: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Current Daily Step Goal:")
                    .font(.headline)
                
                Text("\(goalVM.dailyStepGoal) steps")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                TextField("Enter new goal", text: $newGoal)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 200)
                
                Button("Update Goal") {
                    if let goal = Int(newGoal), goal > 0 {
                        goalVM.dailyStepGoal = goal
                        newGoal = ""
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Set Goals")
        }
    }
}

#Preview {
    GoalsView()
}
