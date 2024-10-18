//
//  FilterCalendarHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import Foundation

struct FilterCalendarHelper {
    public static func filter(by filterCalendar: FilterCalendar, appointments: [StudioAppointment]) -> [StudioAppointment] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 3600)! // UTC+1
        calendar.locale = Locale(identifier: "pt_PT")
        calendar.firstWeekday = 2 // Set the first weekday to Monday

        let now = Date()
        
        switch filterCalendar {
        case .today:
            // Start of today (ignores time)
            let startOfToday = calendar.startOfDay(for: now)
            let endOfToday = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
            return appointments.filter { $0.date >= startOfToday && $0.date < endOfToday }
            
        case .week:
            // Start of the current week
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            let startOfWeekLocal = calendar.startOfDay(for: startOfWeek) // Start of the week at midnight
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeekLocal)! // End of the week
            return appointments.filter { $0.date > startOfWeekLocal && $0.date <= endOfWeek }
            
        case .month:
            // Start of the current month
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            let startOfMonthLocal = calendar.startOfDay(for: startOfMonth) // Ensure it's local time
            let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonthLocal)!
            return appointments.filter { $0.date >= startOfMonthLocal && $0.date < endOfMonth }
            
        case .all:
            return appointments
        }
    }
}
