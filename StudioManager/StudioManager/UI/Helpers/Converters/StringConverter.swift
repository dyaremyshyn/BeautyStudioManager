//
//  StringConverter.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/03/2025.
//

import Foundation

struct StringConverter {
    static func convertDoubleToString(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    static func convertStringToDouble(_ string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter.number(from: string)?.doubleValue ?? 0.0
    }
}
