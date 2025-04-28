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
}
