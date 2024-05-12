//
//  Appointment.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

enum AppointmentType: String, CaseIterable {
    case makeup = "Maquilhagem"
    case bride = "Noiva"
    case nailsType1 = "Unhas verniz gel"
    case nailsType2 = "Unhas gel"
    case nailsType3 = "Unhas acrílico"
    case lashes = "Lifting de pestanas"
    case skinCleansing = "Limpeza de pele"
    case brideTest = "Prova de noiva"
    case eyebrow = "Sobrancelha"
    case hairstyle = "Penteado"
}

struct Appointment: Equatable, Identifiable {
    let id: UUID
    let clientName: String
    let date: Date
    let price: Double
    let type: String
    let inResidence: Bool
    let clientNumber: String?
    
    func initials() -> String {
        let words = clientName.components(separatedBy: " ")
        var initials = ""
        for word in words {
            if let firstCharacter = word.first {
                initials.append(firstCharacter)
            }
        }
        return initials.uppercased()
    }
    
    public static func map(appointment: AppointmentEntity) -> Appointment {
        Appointment(
            id: appointment.id ?? UUID(),
            clientName: appointment.clientName ?? "Sem nome",
            date: appointment.date!,
            price: appointment.price,
            type: appointment.type ?? "Sem tipo",
            inResidence: appointment.inResidence,
            clientNumber: appointment.clientNumber
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
    
#if DEBUG
    static let example = Appointment(
        id: UUID(),
        clientName: "Nádia Nunes",
        date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!,
        price: 30,
        type: AppointmentType.makeup.rawValue,
        inResidence: false,
        clientNumber: "914535341"
    )
    static let allCustomers = [
        Appointment(
            id: UUID(),
            clientName: "Vera Nunes",
            date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!,
            price: 12.5,
            type: AppointmentType.nailsType1.rawValue,
            inResidence: false,
            clientNumber: nil
        ),
        Appointment(
            id: UUID(),
            clientName: "Anabela Nunes",
            date: Calendar.current.date(byAdding: .day, value: 3, to: .now)!,
            price: 30,
            type: AppointmentType.skinCleansing.rawValue,
            inResidence: false,
            clientNumber: nil
        ),
        Appointment(
            id: UUID(),
            clientName: "Patricia Nunes",
            date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!,
            price: 10,
            type: AppointmentType.lashes.rawValue,
            inResidence: false,
            clientNumber: nil
        ),
        Appointment(
            id: UUID(),
            clientName: "Clara Cruz",
            date: Calendar.current.date(byAdding: .day, value: 5, to: .now)!,
            price: 30,
            type: AppointmentType.makeup.rawValue,
            inResidence: true,
            clientNumber: nil
        ),
        Appointment(
            id: UUID(),
            clientName: "Marilia Prima",
            date: Calendar.current.date(byAdding: .month, value: 2, to: .now)!,
            price: 150,
            type: AppointmentType.bride.rawValue,
            inResidence: true,
            clientNumber: nil
        )
    ]
#endif
}
