//
//  ServiceValidator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/03/2025.
//

import Foundation

enum ServiceValidationError {
    case emptyName
    case emptyPrice
    case invalidDuration
}

enum ServiceValidator {
    static func validate(name: String?, price: String?, duration: Date?) -> [ServiceValidationError] {
        [
            validate(name: name),
            validate(price: price),
            validate(duration: duration)
        ].compactMap { $0 }
    }
}

private extension ServiceValidator {
    static func validate(name: String?) -> ServiceValidationError? {
        return isEmptyField(name) ? .emptyName : nil
    }
    
    static func validate(price: String?) -> ServiceValidationError? {
        return isEmptyField(price) ? .emptyPrice : nil
    }
    
    static func validate(duration: Date?) -> ServiceValidationError? {
        guard let date = duration else { return .invalidDuration }
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let totalSeconds = (components.hour ?? 0) * 3600 + (components.minute ?? 0) * 60
        let minimumDuration: TimeInterval = 20 * 60 // 15 minutos em segundos
        return totalSeconds >= Int(minimumDuration) ? nil : .invalidDuration
    }
        
    static func isEmptyField(_ field: String?) -> Bool {
        guard let field else { return true }
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
