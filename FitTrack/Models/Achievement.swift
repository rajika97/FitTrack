import Foundation

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    var isUnlocked: Bool
}
