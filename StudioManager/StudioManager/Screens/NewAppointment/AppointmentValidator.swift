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
    case emptyPricePerKm
    case emptyTotalDistance
    case invalidDate
}

enum AppointmentValidator {
    public struct Form {
        let name: String?
        let price: String?
        let date: Date?
        let pricePerKm: String?
        let totalDistance: String?
    }
    
    static func validate(form: Form) -> [AppointmentValidationError] {
        [
            validate(name: form.name),
            validate(price: form.price),
            validate(date: form.date),
            validate(pricePerKm: form.pricePerKm),
            validate(totalDistance: form.totalDistance)
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
    
    static func validate(pricePerKm: String?) -> AppointmentValidationError? {
        return isEmptyField(pricePerKm) ? .emptyPricePerKm : nil
    }
    
    static func validate(totalDistance: String?) -> AppointmentValidationError? {
        return isEmptyField(totalDistance) ? .emptyTotalDistance : nil
    }
    
    static func isEmptyField(_ field: String?) -> Bool {
        guard let field else { return true }
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
