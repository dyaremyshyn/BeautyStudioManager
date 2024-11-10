//
//  Service.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

public struct Service: Hashable {
    let id: UUID
    let type: String
    let price: Double
    let duration: Double
    
    public static func map(type: ServiceEntity) -> Service {
        Service(
            id: type.id ?? UUID(),
            type: type.name ?? "",
            price: type.price,
            duration: type.duration
        )
    }
    
    public static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let allPrices = [
        Service(
            id: UUID(),
            type: "Noiva",
            price: 150,
            duration: 90 * 60 // 90 minutes in seconds
        ),
        Service(
            id: UUID(),
            type: "Limpeza de pele",
            price: 30,
            duration: 45 * 60 // 45 minutes in seconds
        ),
    ]
}
