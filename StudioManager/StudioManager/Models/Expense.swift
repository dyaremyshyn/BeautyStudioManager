//
//  Expense.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

import Foundation

public struct Expense: Equatable, Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let price: Double
    public let date: Date
    
    public static func map(expense: ExpenseEntity) -> Expense {
        Expense(
            id: expense.id ?? UUID(),
            name: expense.name ?? "",
            price: expense.amount,
            date: expense.date ?? .now
        )
    }
}
