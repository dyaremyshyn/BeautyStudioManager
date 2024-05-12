//
//  Appointment.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

struct Appointment: Equatable, Identifiable {
    let id: UUID
    let clientName: String
    let date: String
    let price: Double
    let type: String
    let inStudio: Bool
    
    public static func map(appointment: AppointmentEntity) -> Appointment {
        Appointment(
            id: appointment.id ?? UUID(),
            clientName: appointment.clientName ?? "Sem nome",
            date: dateFormatter.string(from: appointment.date!),
            price: appointment.price,
            type: appointment.type ?? "Sem tipo",
            inStudio: appointment.inStudio
        )
    }
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
