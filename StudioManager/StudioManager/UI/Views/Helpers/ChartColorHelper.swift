//
//  ChartColorHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 23/10/2024.
//

import Foundation
import UIKit

struct ChartColorHelper {
    
    public static func getColor(for type: AppointmentType) -> UIColor {
        switch type {
        case .makeup: return .systemPink
        case .bride: return.lightGray
        case .brideTest: return.cyan
        case .hairstyle: return .brown
        case .nailsType1: return .orange
        case .nailsType2: return .red
        case .nailsType3: return .yellow
        case .lashes: return .green
        case .eyebrow: return .blue
        case .skinCleansing: return .purple
        }
    }
}
