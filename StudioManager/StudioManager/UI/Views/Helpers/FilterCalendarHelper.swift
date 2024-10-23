//
//  FilterCalendarHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import Foundation

struct FilterCalendarHelper {
    
    public static func filter(by filterCalendar: FilterCalendar, appointments: [StudioAppointment]) -> [StudioAppointment] {
        let calendar = createCalendar()
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
            return appointments.filter { $0.date > now && $0.date <= endOfWeek }
            
        case .month:
            // Start of the current month
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            let startOfMonthLocal = calendar.startOfDay(for: startOfMonth)
            let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonthLocal)!
            return appointments.filter { $0.date >= now && $0.date < endOfMonth }
            
        case .all:
            return appointments.filter { $0.date >= now }
        }
    }
    
    public static func filterBalance(by filterCalendar: FilterCalendar, appointments: [StudioAppointment]) -> [StudioAppointment] {
        let calendar = createCalendar()
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
            let startOfMonthLocal = calendar.startOfDay(for: startOfMonth)
            let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonthLocal)!
            return appointments.filter { $0.date >= startOfMonthLocal && $0.date < endOfMonth }
            
        case .all:
            // Start of the current year
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
            let startOfYearLocal = calendar.startOfDay(for: startOfYear)
            return appointments.filter { $0.date >= startOfYearLocal && $0.date <= now }
        }
    }
}

extension FilterCalendarHelper {
    
    private static func createCalendar() -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 3600)! // UTC+1
        calendar.locale = Locale(identifier: "pt_PT")
        calendar.firstWeekday = 2
        return calendar
    }
}
