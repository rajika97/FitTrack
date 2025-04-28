import SwiftUI

struct ProgressRingView: View {
    var progress: Double  // Value between 0.0 and 1.0
    var stepsText: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.2)
                .foregroundColor(.green)
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.green, .blue]), center: .center),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeOut(duration: 0.8), value: progress)
            
            VStack {
                Text(stepsText)
                    .font(.title)
                    .bold()
                Text("Steps")
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ProgressRingView(progress: 0.7, stepsText: "3500 / 5000")
}
