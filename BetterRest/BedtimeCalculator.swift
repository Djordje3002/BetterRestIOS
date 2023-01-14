import CoreML
import Foundation

final class BedtimeCalculator {
    private var cachedModel: SleepCalculator?

    private func loadModel() throws -> SleepCalculator {
        if let cachedModel { return cachedModel }
        let model = try SleepCalculator(configuration: MLModelConfiguration())
        cachedModel = model
        return model
    }

    func bedtime(wakeUp: Date, sleepHours: Double, coffeeCups: Int) throws -> Date {
        let model = try loadModel()
        let prediction = try model.prediction(
            wake: BedtimeSchedule.wakeSeconds(for: wakeUp),
            estimatedSleep: sleepHours,
            coffee: Double(coffeeCups)
        )
        return try BedtimeSchedule.bedtime(wakeUp: wakeUp, sleepDuration: prediction.actualSleep)
    }
}
