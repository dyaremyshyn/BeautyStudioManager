//
//  Appointment.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

public struct Appointment {
    
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
    
    static let example = StudioAppointment(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!,
        price: 12.5,
        type: AppointmentType.nailsType1,
        inResidence: false,
        name: "Vera Nunes",
        phoneNumber: "912325234"
    )
    
    static let allCustomers = [
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!,
            price: 12.5,
            type: AppointmentType.nailsType1,
            inResidence: false,
            name: "Vera Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!,
            price: 30,
            type: AppointmentType.skinCleansing,
            inResidence: false,
            name: "Anabela Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!,
            price: 25,
            type: AppointmentType.lashes,
            inResidence: false,
            name: "Patricia Nunes",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .weekday, value: 4, to: .now)!,
            price: 35,
            type: AppointmentType.makeup,
            inResidence: false,
            name: "Clara Cruz",
            phoneNumber: "912325234"
        ),
        StudioAppointment(
            id: UUID(),
            date: Calendar.current.date(byAdding: .month, value: 2, to: .now)!,
            price: 150,
            type: AppointmentType.bride,
            inResidence: false,
            name: "Marilia Prima",
            phoneNumber: "912325234"
        )        
    ]
}
