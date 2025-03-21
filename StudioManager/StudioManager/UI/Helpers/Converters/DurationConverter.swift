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
        Date(timeIntervalSince1970: duration)
    }
        
}
