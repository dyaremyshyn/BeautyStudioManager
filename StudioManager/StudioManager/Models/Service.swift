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
    let icon: String
    
    public static func map(type: ServiceEntity) -> Service {
        Service(
            id: type.id ?? UUID(),
            type: type.name ?? "",
            price: type.price,
            duration: type.duration,
            icon: type.icon ?? StudioTheme.serviceDefaultImage
        )
    }
}
