//
//  ExpenseViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import Foundation
import Combine

class ExpenseViewModel: ObservableObject {
    @Published var expenseName: String!
    @Published var expensePrice: String!
    @Published var expenseDate: Date!
    @Published var validationErrors: [ExpenseValidationError] = []
    @Published var showToast: Bool = false
    private var subscriptions: [AnyCancellable] = []
    
    private let persistenceService: ExpensePersistenceLoader
    
    init(persistenceService: ExpensePersistenceLoader) {
        self.persistenceService = persistenceService
        resetAllFields()
        
        Publishers.CombineLatest($expenseName, $expensePrice)
            .sink { [weak self] name, price in
                self?.validationErrors = ExpenseValidator.validate(name: name, price: price)
            }
            .store(in: &subscriptions)
    }
    
    public func saveExpense() {
        let expense = Expense(
            id: UUID(),
            name: expenseName,
            amount: Double(expensePrice) ?? 0,
            date: expenseDate
        )
        
        // Save created expense to core data
        persistenceService.add(expense: expense)
        showToast = true
        
        // Reset all fields
        resetAllFields()
    }
    
    private func resetAllFields() {
        expenseName = ""
        expensePrice = ""
        expenseDate = .now
    }
}
