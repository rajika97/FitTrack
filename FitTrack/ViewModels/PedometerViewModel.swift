import Foundation
import CoreMotion

class PedometerViewModel: ObservableObject {
    private var pedometer = CMPedometer()
    
    @Published var steps: Int = 0
    @Published var distance: Double = 0.0  // in meters

    init() {
        startPedometerUpdates()
    }

    func startPedometerUpdates() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Step counting not available")
            return
        }

        pedometer.startUpdates(from: Calendar.current.startOfDay(for: Date())) { data, error in
            DispatchQueue.main.async {
                if let data = data {
                    self.steps = data.numberOfSteps.intValue
                    self.distance = data.distance?.doubleValue ?? 0.0
                } else if let error = error {
                    print("Pedometer error: \(error.localizedDescription)")
                }
            }
        }
    }
}
