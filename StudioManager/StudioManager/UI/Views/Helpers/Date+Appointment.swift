//
//  Date+Appointment.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import Foundation

extension Date {
    
    var appointmentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_PT")
        dateFormatter.dateFormat = "E, dd MMM"
        return dateFormatter.string(from: self)
    }
    
    var appointmentDateTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_PT")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
