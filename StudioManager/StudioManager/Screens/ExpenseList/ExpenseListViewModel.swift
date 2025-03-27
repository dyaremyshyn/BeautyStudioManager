//
//  ExpenseListViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import Foundation

class ExpenseListViewModel : ObservableObject {
    @Published private(set) var expenses: [Expense] = []
    @Published private(set) var errorMessage: String? = nil
    
    private let persistenceService: ExpensePersistenceLoader

    init(persistenceService: ExpensePersistenceLoader) {
        self.persistenceService = persistenceService
    }
    
    func fetchData() {
        expenses = persistenceService.fetchAll().sorted { $0.date > $1.date }
    }
    
    func deleteExpense(_ expenseId: UUID) {
        let success = persistenceService.delete(expenseId: expenseId)
        guard success else {
            errorMessage = tr.errorDeletingExpense
            return
        }
        fetchData()
    }
}
