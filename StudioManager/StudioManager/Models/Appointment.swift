//
//  Appointment.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

public struct Appointment: Equatable, Identifiable {
    public let id: UUID
    let date: Date
    let price: Double
    let type: String
    let inResidence: Bool
        
    public static func map(appointment: AppointmentEntity) -> Appointment {
        Appointment(
            id: appointment.id ?? UUID(),
            date: appointment.date!,
            price: appointment.price,
            type: appointment.type ?? "Sem tipo",
            inResidence: appointment.inResidence
        )
    }
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    public static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.currencyCode = "EUR"
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    
    static let allCustomers = [
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!,
            price: 12.5,
            type: AppointmentType.nailsType1.rawValue,
            inResidence: false,
            name: "Vera Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!,
            price: 30,
            type: AppointmentType.skinCleansing.rawValue,
            inResidence: false,
            name: "Anabela Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!,
            price: 25,
            type: AppointmentType.lashes.rawValue,
            inResidence: false,
            name: "Patricia Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .weekday, value: 4, to: .now)!,
            price: 35,
            type: AppointmentType.makeup.rawValue,
            inResidence: false,
            name: "Clara Cruz",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .month, value: 2, to: .now)!,
            price: 150,
            type: AppointmentType.bride.rawValue,
            inResidence: false,
            name: "Marilia Prima",
            phoneNumber: "912325234"
        )        
    ]
}
