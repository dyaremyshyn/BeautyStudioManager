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
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    static func convertStringToDouble(_ string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let doubleString = string.replacingOccurrences(of: ",", with: ".")
        return formatter.number(from: doubleString)?.doubleValue ?? 0.0
    }
}
