//
//  AppointmentTypeModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

public struct AppointmentTypeModel: Hashable {
    let id: UUID
    let appointmentTypeName: String
    let price: Double
    let duration: TimeInterval
    
    public static func map(type: AppointmentTypeEntity) -> AppointmentTypeModel {
        AppointmentTypeModel(
            id: type.id ?? UUID(),
            appointmentTypeName: type.name ?? "",
            price: type.price,
            duration: type.duration?.timeIntervalSince1970 ?? 0
        )
    }
    
    public static func == (lhs: AppointmentTypeModel, rhs: AppointmentTypeModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let allPrices = [
        AppointmentTypeModel(
            id: UUID(),
            appointmentTypeName: "Noiva",
            price: 150,
            duration: 90 * 60 // 90 minutes in seconds
        ),
        AppointmentTypeModel(
            id: UUID(),
            appointmentTypeName: "Limpeza de pele",
            price: 30,
            duration: 45 * 60 // 45 minutes in seconds
        ),
    ]
}
