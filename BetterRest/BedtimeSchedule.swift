import Foundation

enum BedtimeSchedule {
    static func defaultWakeTime(now: Date = Date(), calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: SleepPreferences.defaultWakeHour, minute: 0, second: 0, of: now) ?? now
    }
}
