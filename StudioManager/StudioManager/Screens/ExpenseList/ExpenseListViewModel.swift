//
//  ExpenseListViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import Foundation

class ExpenseListViewModel : ObservableObject {
    @Published private(set) var expenses: [Expense] = []
    @Published var showToast: Bool = false
    var groupedExpenses: [Int: [Int: [Expense]]] {
        let calendar = Calendar.current
        let byYear = Dictionary(grouping: expenses) { expense in
            calendar.component(.year, from: expense.date)
        }
        return byYear.mapValues { expenses in
            Dictionary(grouping: expenses) { expense in
                calendar.component(.month, from: expense.date)
            }
        }
    }
    
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
            showToast = true
            return
        }
        fetchData()
    }
}
