//
//  ExpensePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

public protocol ExpensePersistenceLoader {
    func fetchAll() -> [Expense]
    func add(expense: Expense)
}
