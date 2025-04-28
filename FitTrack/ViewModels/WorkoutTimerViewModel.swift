import Foundation
import CoreData
import Combine

class WorkoutTimerViewModel: ObservableObject {
    @Published var isRunning = false
    @Published var elapsedTime: TimeInterval = 0
    @Published var pastSessions: [WorkoutSession] = []
    
    private var timer: AnyCancellable?
    private let context = PersistenceController.shared.container.viewContext

    // Start Workout Timer
    func startTimer() {
        isRunning = true
        elapsedTime = 0
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedTime += 1
            }
    }
    
    // Stop Workout Timer
    func stopTimer() {
        isRunning = false
        timer?.cancel()
    }
    
    // Save Workout Session with Name
    func saveSession(with name: String) {
        let session = WorkoutSession(context: context)
        session.date = Date()
        session.duration = elapsedTime
        session.name = name.isEmpty ? "Unnamed Session" : name

        do {
            try context.save()
            print("Workout session '\(session.name ?? "Unnamed")' saved!")
        } catch {
            print("❌ Failed to save workout session: \(error.localizedDescription)")
        }
    }
    
    // Fetch Past Workout Sessions
    func fetchSessions() {
        let request: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            pastSessions = try context.fetch(request)
        } catch {
            print("❌ Failed to fetch sessions: \(error.localizedDescription)")
        }
    }
}
