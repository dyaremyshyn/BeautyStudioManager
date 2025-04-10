//
//  StudioAppointment.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/10/2024.
//

import Foundation
import CoreGraphics

enum StudioSection: CaseIterable {
    case main
}

public struct StudioAppointment: Equatable, Identifiable, Hashable {
    public let id: UUID
    let date: Date
    let price: Double
    let type: String 
    let inResidence: Bool
    let name: String
    let phoneNumber: String?
    let duration: Double
    let addedToCalendar: Bool
    let icon: String
    let color: CGColor
    let calendarEventId: String?
        
    public static func map(appointment: StudioEntity) -> StudioAppointment {
        StudioAppointment(
            id: appointment.id ?? UUID(),
            date: appointment.date!,
            price: appointment.price,
            type: appointment.type ?? "Maquilhagem",
            inResidence: appointment.inResidence,
            name: appointment.name ?? "Sem nome",
            phoneNumber: appointment.phoneNumber,
            duration: appointment.duration,
            addedToCalendar: appointment.addedToCalendar,
            icon: appointment.icon ?? StudioTheme.serviceDefaultImage,
            color: appointment.color?.unarchiveColor ?? .random,
            calendarEventId: appointment.calendarEventId
        )
    }
}

extension StudioAppointment {
    var endDate: Date {
        date.addingTimeInterval(duration)
    }
}
