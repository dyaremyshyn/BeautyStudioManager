//
//  Appointment.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

enum AppointmentType: String {
    case makeup = "Makeup"
    case bride = "Noiva"
    case nailsType1 = "Unhas verniz gel"
    case nailsType2 = "Unhas gel"
    case nailsType3 = "Unhas acrílico"
    case lashes = "Pestanas"
    case skinCleansing = "Limpeza de pele"
    case brideTest = "Prova de noiva"
    case eyebrow = "Sobrancelha"
    case hairstyle = "Penteado"
}

struct Appointment: Equatable, Identifiable {
    let id: UUID
    let clientName: String
    let date: String
    let price: Double
    let type: String
    let inStudio: Bool
    
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
    
#if DEBUG
    static let example = Appointment(
        id: UUID(),
        clientName: "Nádia Nunes",
        date: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: .now)!),
        price: 30,
        type: AppointmentType.makeup.rawValue,
        inStudio: false
    )
    static let allCustomers = [
        Appointment(
            id: UUID(),
            clientName: "Vera Nunes",
            date: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 2, to: .now)!),
            price: 12.5,
            type: AppointmentType.nailsType1.rawValue,
            inStudio: true
        ),
        Appointment(
            id: UUID(),
            clientName: "Anabela Nunes",
            date: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 3, to: .now)!),
            price: 30,
            type: AppointmentType.skinCleansing.rawValue,
            inStudio: true
        ),
        Appointment(
            id: UUID(),
            clientName: "Patricia Nunes",
            date: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 4, to: .now)!),
            price: 10,
            type: AppointmentType.lashes.rawValue,
            inStudio: true
        ),
        Appointment(
            id: UUID(),
            clientName: "Clara Cruz",
            date: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 5, to: .now)!),
            price: 30,
            type: AppointmentType.makeup.rawValue,
            inStudio: false
        ),
        Appointment(
            id: UUID(),
            clientName: "Marilia Casamento",
            date: dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: 2, to: .now)!),
            price: 100,
            type: AppointmentType.bride.rawValue,
            inStudio: false
        )
    ]
#endif
}
