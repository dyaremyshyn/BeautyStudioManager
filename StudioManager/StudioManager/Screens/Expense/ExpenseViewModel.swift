//
//  ExpenseViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var expenseName: String!
    @Published var expenseAmount: String!
    @Published var expenseDate: Date!
    
    private let persistenceService: ExpensePersistenceLoader
    
    init(persistenceService: ExpensePersistenceLoader) {
        self.persistenceService = persistenceService
        resetAllFields()
    }
    
    public func saveExpense() {
        let expense = Expense(
            id: UUID(),
            name: expenseName,
            amount: Double(expenseAmount) ?? 0,
            date: expenseDate
        )
        
        // Save created expense to core data
        persistenceService.add(expense: expense)
        
        // Reset all fields
        resetAllFields()
    }
    
    private func resetAllFields() {
        expenseName = ""
        expenseAmount = ""
        expenseDate = .now
    }
}
