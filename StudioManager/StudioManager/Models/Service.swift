//
//  Service.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation
import CoreGraphics
import UIKit

public struct Service: Hashable {
    let id: UUID
    let type: String
    let price: Double
    let duration: Double
    let icon: String
    let color: CGColor
    
    init(id: UUID, type: String, price: Double, duration: Double, icon: String, color: CGColor) {
        self.id = id
        self.type = type
        self.price = price
        self.duration = duration
        self.icon = icon
        self.color = color
    }
    
    public static func map(type: ServiceEntity) -> Service {
        Service(
            id: type.id ?? UUID(),
            type: type.name ?? "",
            price: type.price,
            duration: type.duration,
            icon: type.icon ?? StudioTheme.serviceDefaultImage,
            color: type.color?.unarchiveColor ?? .random
        )
    }
}
