import SwiftUI

struct BadgeView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            
            Text("Goal Achieved!")
                .font(.title2)
                .bold()
                .foregroundColor(.green)
        }
        .transition(.scale)
    }
}

#Preview {
    BadgeView()
}
