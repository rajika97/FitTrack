import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Welcome to Profile!")
                .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
