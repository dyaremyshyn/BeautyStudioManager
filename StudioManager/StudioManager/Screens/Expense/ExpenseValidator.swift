//
//  ExpenseValidator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/03/2025.
//

import Foundation

enum ExpenseValidationError {
    case emptyName
    case emptyPrice
}

enum ExpenseValidator {
    static func validate(name: String?, price: String?) -> [ExpenseValidationError] {
        [
            validate(name: name),
            validate(price: price),
        ].compactMap { $0 }
    }
}

private extension ExpenseValidator {
    static func validate(name: String?) -> ExpenseValidationError? {
        return isEmptyField(name) ? .emptyName : nil
    }
    
    static func validate(price: String?) -> ExpenseValidationError? {
        return isEmptyField(price) ? .emptyPrice : nil
    }
        
    static func isEmptyField(_ field: String?) -> Bool {
        guard let field else { return true }
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
