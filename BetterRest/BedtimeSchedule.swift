import Foundation

enum BedtimeSchedule {
    enum CalculationError: Error {
        case invalidPrediction
    }

    static func bedtime(wakeUp: Date, sleepDuration: TimeInterval) throws -> Date {
        guard sleepDuration.isFinite, sleepDuration > 0, sleepDuration <= 86_400 else {
            throw CalculationError.invalidPrediction
        }
        return wakeUp.addingTimeInterval(-sleepDuration)
    }

    static func wakeSeconds(for date: Date, calendar: Calendar = .current) -> Double {
        let components = calendar.dateComponents([.hour, .minute], from: date)
        return Double((components.hour ?? 0) * 3_600 + (components.minute ?? 0) * 60)
    }

    static func defaultWakeTime(now: Date = Date(), calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: SleepPreferences.defaultWakeHour, minute: 0, second: 0, of: now) ?? now
    }
}
