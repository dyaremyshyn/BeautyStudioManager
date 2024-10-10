//
//  StudioAppointment.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/10/2024.
//

import Foundation

public struct StudioAppointment: Equatable, Identifiable, Hashable {
    public let id: UUID
    let date: Date
    let price: Double
    let type: String
    let inResidence: Bool
    let name: String
    let phoneNumber: String?
        
    public static func map(appointment: StudioEntity) -> StudioAppointment {
        StudioAppointment(
            id: appointment.id ?? UUID(),
            date: appointment.date!,
            price: appointment.price,
            type: appointment.type ?? "Sem tipo",
            inResidence: appointment.inResidence,
            name: appointment.name ?? "Sem nome",
            phoneNumber: appointment.phoneNumber
        )
    }
    
    public static func == (lhs: StudioAppointment, rhs: StudioAppointment) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
