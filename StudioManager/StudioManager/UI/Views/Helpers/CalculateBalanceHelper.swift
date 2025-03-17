//
//  CalculateBalanceHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 23/10/2024.
//

import Foundation

struct CalculateBalanceHelper {
    
    public static func calculateBalance(appointments: [StudioAppointment]) -> String {
        var totalAmount: Double = 0
        
        for appointment in appointments {
            totalAmount += appointment.price
        }
        return String(format: "%.2f", totalAmount) + "€"
    }
    
    public static func calculateExpense(expenses: [Expense]) -> String {
        var totalAmount: Double = 0
        
        for expense in expenses {
            totalAmount += expense.amount
        }
        return String(format: "%.2f", totalAmount) + "€"
    }
}
