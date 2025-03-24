//
//  DurationConverter.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import Foundation

struct DurationConverter {
    static func convertDurationToTimeInterval(_ duration: Date) -> TimeInterval {
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: duration)
        let minutes = calendar.component(.minute, from: duration)

        // Convert hours and minutes to TimeInterval
        let timeInterval = TimeInterval(hours * 3600 + minutes * 60)
        
        return timeInterval
    }
    
    static func convertDurationToDate(_ duration: Double) -> Date {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        return startOfDay.addingTimeInterval(duration)
    }
        
    static func formattedDuration(_ duration: Double) -> String {
        let timeInterval = TimeInterval(duration)
        let totalMinutes = Int(timeInterval) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        var components: [String] = []
        
        if hours > 0 {
            components.append("\(hours) hora\(hours > 1 ? "s" : "")")
        }
        
        if minutes > 0 || components.isEmpty {
            components.append("\(minutes) minuto\(minutes > 1 ? "s" : "")")
        }
        
        return components.joined(separator: " e ")
    }
}
