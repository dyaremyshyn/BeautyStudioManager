//
//  ExpensePersistenceService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

import CoreData

class ExpensePersistenceService: ExpensePersistenceLoader {
    private static let expenseEntity = "ExpenseEntity"
    private let context: NSManagedObjectContext

    public init() {
        self.context = CoreDataStack.shared.context
    }
    
    func fetchAll() -> [Expense] {
        var expenses: [Expense] = []
        context.performAndWait {
            let request = NSFetchRequest<ExpenseEntity>(entityName: ExpensePersistenceService.expenseEntity)
            do {
                let result = try context.fetch(request)
                expenses = result.map { Expense.map(expense: $0) }
                expenses.sort { $0.date < $1.date }
            } catch {
                print("Error fetching expenses: \(error.localizedDescription)")
            }
        }
        return expenses
    }
    
    private func fetchExpenseEntity(for expense: Expense) -> ExpenseEntity? {
        let request = NSFetchRequest<ExpenseEntity>(entityName: ExpensePersistenceService.expenseEntity)
        request.predicate = NSPredicate(format: "id == %@", expense.id as CVarArg)
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Error fetching ExpenseEntity: \(error.localizedDescription)")
            return nil
        }
    }
    
    func add(expense: Expense) {
        context.performAndWait {
            if let existingExpense = fetchExpenseEntity(for: expense) {
                existingExpense.name = expense.name
                existingExpense.date = expense.date
                existingExpense.amount = expense.amount
            } else {
                let newExpense = ExpenseEntity(context: context)
                newExpense.id = expense.id
                newExpense.name = expense.name
                newExpense.date = expense.date
                newExpense.amount = expense.amount
            }
            
            do {
                try context.save()
            } catch {
                print("Error saving expense: \(error.localizedDescription)")
            }
        }
    }
    
    func delete(expenseId: UUID) -> Bool {
        var success = false
        context.performAndWait {
            let request = NSFetchRequest<ExpenseEntity>(entityName: ExpensePersistenceService.expenseEntity)
            request.predicate = NSPredicate(format: "id == %@", expenseId as CVarArg)
            do {
                let result = try context.fetch(request)
                if let entity = result.first {
                    context.delete(entity)
                    try context.save()
                    success = true
                } else {
                    success = false
                }
            } catch {
                print("Error deleting service: \(error)")
                success = false
            }
        }
        return success
    }
}
