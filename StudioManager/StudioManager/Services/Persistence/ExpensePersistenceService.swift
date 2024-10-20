//
//  ExpensePersistenceService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

import CoreData

struct ExpensePersistenceService: ExpensePersistenceLoader {
    private static let modelName = "StudioManager"
    private static let expenseEntity = "ExpenseEntity"

    let container: NSPersistentContainer

    public init() {
        container = NSPersistentContainer(name: ExpensePersistenceService.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getExpenses() -> [Expense] {
        var expenses: [Expense] = []
        
        let request = NSFetchRequest<ExpenseEntity>(entityName: ExpensePersistenceService.expenseEntity)
        
        do {
            let result = try container.viewContext.fetch(request)
            expenses = result.map { Expense.map(expense: $0) }
            expenses.sort(by: { $0.date < $1.date })
        } catch {
            print(error.localizedDescription)
        }
        return expenses
    }
    
    func saveExpense(expense: Expense) {
        let request = NSFetchRequest<ExpenseEntity>(entityName: ExpensePersistenceService.expenseEntity)
        request.predicate = NSPredicate(format: "id == %@", expense.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            guard let editExpense = result.first else {
                print("Expense entity not found with id: \(expense.id)")
                
                let newEntry = ExpenseEntity(context: container.viewContext)
                newEntry.id = expense.id
                newEntry.name = expense.name
                newEntry.date = expense.date
                newEntry.amount = expense.amount
                
                saveData()
                
                return
            }
            
            // Modify the properties of the fetched expense
            editExpense.name = expense.name
            editExpense.date = expense.date
            editExpense.amount = expense.amount
            
            saveData()
            
            print("Expense entity with id \(expense.id) edited successfully")
        } catch {
            print("Error editing expense entity: \(error)")
        }
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
