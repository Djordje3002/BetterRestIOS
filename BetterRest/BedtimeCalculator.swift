import CoreML
import Foundation

final class BedtimeCalculator {
    func bedtime(wakeUp: Date, sleepHours: Double, coffeeCups: Int) throws -> Date {
        let model = try SleepCalculator(configuration: MLModelConfiguration())
        let prediction = try model.prediction(
            wake: BedtimeSchedule.wakeSeconds(for: wakeUp),
            estimatedSleep: sleepHours,
            coffee: Double(coffeeCups)
        )
        return try BedtimeSchedule.bedtime(wakeUp: wakeUp, sleepDuration: prediction.actualSleep)
    }
}
