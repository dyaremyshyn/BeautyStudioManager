//
//  ServiceRevenue.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 25/03/2025.
//

import Foundation
import SwiftUI

struct ServiceRevenue: Identifiable {
    let id = UUID()
    let service: String
    var revenue: Double
    let color: Color
    
    init(service: String, revenue: Double, color: Color = .random) {
        self.service = service
        self.revenue = revenue
        self.color = color
    }
}

extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
