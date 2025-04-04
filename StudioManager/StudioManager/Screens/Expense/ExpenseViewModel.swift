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
    private let expense: Expense?
    private var subscriptions: [AnyCancellable] = []
    
    private let persistenceService: ExpensePersistenceLoader
    
    init(expense: Expense?, persistenceService: ExpensePersistenceLoader) {
        self.expense = expense
        self.persistenceService = persistenceService
        resetAllFields()
        setFields(for: expense)
        
        Publishers.CombineLatest($expenseName, $expensePrice)
            .sink { [weak self] name, price in
                self?.validationErrors = ExpenseValidator.validate(name: name, price: price)
            }
            .store(in: &subscriptions)
    }
    
    public func saveExpense() {
        let expense = Expense(
            id: expense?.id ?? UUID(),
            name: expenseName,
            price: StringConverter.convertStringToDouble(expensePrice),
            date: expenseDate
        )
        
        // Save created expense to core data
        persistenceService.add(expense: expense)
        showToast = true
        
        // Reset all fields
        resetAllFields()
    }
}

private extension ExpenseViewModel {
    func resetAllFields() {
        expenseName = ""
        expensePrice = ""
        expenseDate = .now
    }
    
    func setFields(for expense: Expense?) {
        guard let expense else { return }
        expenseName = expense.name
        expensePrice = expense.price.formatted()
        expenseDate = expense.date
    }
}
