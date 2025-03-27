//
//  ExpensePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

import Foundation

public protocol ExpensePersistenceLoader {
    func fetchAll() -> [Expense]
    func add(expense: Expense)
    func delete(expenseId: UUID) -> Bool
}
