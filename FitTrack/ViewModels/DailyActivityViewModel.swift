import Foundation
import CoreData

class DailyActivityViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext

    func saveTodayActivity(steps: Int, distance: Double) {
        let today = Calendar.current.startOfDay(for: Date())
        
        let fetchRequest: NSFetchRequest<DailyActivity> = DailyActivity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", today as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            let activity = results.first ?? DailyActivity(context: context)
            
            activity.date = today
            activity.steps = Int64(steps)
            activity.distance = distance

            try context.save()
            print("Activity Saved for \(today)")
        } catch {
            print("Failed to save activity: \(error.localizedDescription)")
        }
    }
    
    @Published var weeklyActivities: [DailyActivity] = []

    func fetchWeeklyActivities() {
        let fetchRequest: NSFetchRequest<DailyActivity> = DailyActivity.fetchRequest()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Calendar.current.startOfDay(for: Date()))!
        fetchRequest.predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            weeklyActivities = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch weekly data: \(error.localizedDescription)")
        }
    }

}
