import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Welcome to FitTrack Home!")
                .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
