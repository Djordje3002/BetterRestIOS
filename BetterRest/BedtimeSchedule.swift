import Foundation

enum BedtimeSchedule {
    static func bedtime(wakeUp: Date, sleepDuration: TimeInterval) throws -> Date {
        wakeUp.addingTimeInterval(-sleepDuration)
    }

    static func wakeSeconds(for date: Date, calendar: Calendar = .current) -> Double {
        let components = calendar.dateComponents([.hour, .minute], from: date)
        return Double((components.hour ?? 0) * 3_600 + (components.minute ?? 0) * 60)
    }

    static func defaultWakeTime(now: Date = Date(), calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: SleepPreferences.defaultWakeHour, minute: 0, second: 0, of: now) ?? now
    }
}
