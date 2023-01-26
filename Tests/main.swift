import Foundation

var checks = 0
func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
    precondition(condition(), message)
    checks += 1
}

var calendar = Calendar(identifier: .gregorian)
calendar.timeZone = TimeZone(secondsFromGMT: 0)!
func date(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int = 0) -> Date {
    calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute))!
}

expect(BedtimeSchedule.wakeSeconds(for: date(2023, 1, 1, 0), calendar: calendar) == 0, "Midnight is zero seconds")
expect(BedtimeSchedule.wakeSeconds(for: date(2023, 1, 1, 7, 30), calendar: calendar) == 27_000, "Wake input includes minutes")
expect(BedtimeSchedule.wakeSeconds(for: date(2023, 1, 1, 23, 59), calendar: calendar) == 86_340, "Last minute stays within the day")
expect(BedtimeSchedule.defaultWakeTime(now: date(2023, 1, 15, 20), calendar: calendar) == date(2023, 1, 15, 7), "Default time preserves today's date")
let previousYearBedtime = try BedtimeSchedule.bedtime(wakeUp: date(2023, 1, 1, 7), sleepDuration: 8 * 3_600)
expect(previousYearBedtime == date(2022, 12, 31, 23), "Bedtime crosses the year boundary")
let sameDayBedtime = try BedtimeSchedule.bedtime(wakeUp: date(2023, 1, 1, 10), sleepDuration: 8 * 3_600)
expect(sameDayBedtime == date(2023, 1, 1, 2), "Same-day subtraction is correct")

print("Passed \(checks) schedule checks")
