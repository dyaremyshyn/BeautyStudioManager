//
//  ExpensePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/10/2024.
//

public protocol ExpensePersistenceLoader {
    func getExpenses() -> [StudioAppointment]
    func saveExpense(expense: StudioAppointment)
    func deleteStudioAppointment(appointment: StudioAppointment) -> Bool
}
