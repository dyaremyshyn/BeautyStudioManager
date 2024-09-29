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
}
