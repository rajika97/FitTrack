import Foundation
import CoreData
import Combine

class WorkoutTimerViewModel: ObservableObject {
    @Published var isRunning = false
    @Published var elapsedTime: TimeInterval = 0
    
    private var timer: AnyCancellable?
    private let context = PersistenceController.shared.container.viewContext

    func startTimer() {
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedTime += 1
            }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.cancel()
        saveSession()
        elapsedTime = 0
    }
    
    private func saveSession() {
        let session = WorkoutSession(context: context)
        session.date = Date()
        session.duration = elapsedTime
        
        do {
            try context.save()
            print("Workout session saved!")
        } catch {
            print("Failed to save workout session: \(error.localizedDescription)")
        }
    }
    
    @Published var pastSessions: [WorkoutSession] = []

    func fetchSessions() {
        let request: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            pastSessions = try context.fetch(request)
        } catch {
            print("Failed to fetch sessions: \(error.localizedDescription)")
        }
    }

}
