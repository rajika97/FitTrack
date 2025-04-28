import SwiftUI

struct AchievementsView: View {
    @StateObject private var achievementsVM = AchievementsViewModel()
    
    var body: some View {
        NavigationView {
            List(achievementsVM.achievements) { achievement in
                HStack {
                    Text(achievement.icon)
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading) {
                        Text(achievement.title)
                            .font(.headline)
                        Text(achievement.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if achievement.isUnlocked {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(5)
            }
            .navigationTitle("Achievements")
        }
    }
}

#Preview {
    AchievementsView()
}
