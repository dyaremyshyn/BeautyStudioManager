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
    
    init(service: String, revenue: Double, color: CGColor) {
        self.service = service
        self.revenue = revenue
        self.color = Color(cgColor: color)
    }
}
