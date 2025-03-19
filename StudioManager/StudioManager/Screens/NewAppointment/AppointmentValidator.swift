//
//  AppointmentValidator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/03/2025.
//

import Foundation

enum AppointmentValidationError {
    case emptyClientName
    case emptyPrice
    case invalidDate
}

enum AppointmentValidator {
    static func validate(name: String?, price: String?, date: Date?) -> [AppointmentValidationError] {
        [
            validate(name: name),
            validate(price: price),
            validate(date: date)
        ].compactMap { $0 }
    }
}

private extension AppointmentValidator {
    static func validate(name: String?) -> AppointmentValidationError? {
        return isEmptyField(name) ? .emptyClientName : nil
    }
    
    static func validate(price: String?) -> AppointmentValidationError? {
        return isEmptyField(price) ? .emptyPrice : nil
    }
    
    static func validate(date: Date?) -> AppointmentValidationError? {
        guard let date else { return .invalidDate }
        return date <= Date() ? .invalidDate : nil
    }
    
    static func isEmptyField(_ field: String?) -> Bool {
        guard let field else { return true }
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
