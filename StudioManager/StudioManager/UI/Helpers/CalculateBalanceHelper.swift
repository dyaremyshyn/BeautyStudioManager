//
//  CalculateBalanceHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 23/10/2024.
//

import Foundation

struct CalculateBalanceHelper {
    
    static func calculateIncome(appointments: [StudioAppointment]) -> String {
        return calculateTotal(items: appointments) { $0.price }
    }
    
    static func calculateExpense(expenses: [Expense]) -> String {
        return calculateTotal(items: expenses) { $0.price }
    }
    
    static func calculateBalance(appointments: [StudioAppointment], expenses: [Expense]) -> String {
        let income = appointments.reduce(0) { $0 + $1.price }
        let expense = expenses.reduce(0) { $0 + $1.price }
        let balance = income - expense
        return String(format: "%.2f", balance) + "€"
    }
    
    private static func calculateTotal<T>(items: [T], valueExtractor: (T) -> Double) -> String {
        let totalAmount = items.reduce(0) { $0 + valueExtractor($1) }
        return String(format: "%.2f", totalAmount) + "€"
    }
}
