//
//  BalanceViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import Foundation

class BalanceViewModel: ObservableObject {
    // Appointments
    private var allAppointments: [StudioAppointment] = []
    private var appointments: [StudioAppointment] = []
    // Expenses
    private var allExpenses: [Expense] = []
    private var expenses: [Expense] = []
    // Prop
    @Published private(set) var appointmentsType: [AppointmentType] = []
    @Published private(set) var expectedBalance: String = ""
    @Published private(set) var expense: String = ""
    @Published private(set) var errorMessage: String? = nil
    private var filterCalendar: FilterCalendar = .today
    weak var coordinator: BalanceCoordinator?

    private let appointmentPersistenceService: AppointmentPersistenceLoader
    private let expensePersistenceService: ExpensePersistenceLoader

    init(appointmentPersistenceService: AppointmentPersistenceLoader, expensePersistenceService: ExpensePersistenceLoader) {
        self.appointmentPersistenceService = appointmentPersistenceService
        self.expensePersistenceService = expensePersistenceService
    }
    
    public func fetchAppointments() {
        allAppointments = appointmentPersistenceService.getStudioAppointments()
        allExpenses = expensePersistenceService.getExpenses()
        errorMessage = nil
        
#if DEBUG
        allAppointments = allAppointments.count == 0 ? Appointment.allCustomers : allAppointments
#endif
        filterBalance(by: filterCalendar)
    }
    
    public func filterBalance(by filterCalendar: FilterCalendar) {
        self.filterCalendar = filterCalendar
        appointments = FilterCalendarHelper.filterBalance(by: filterCalendar, appointments: allAppointments)
        expenses = FilterCalendarHelper.filterExpense(by: filterCalendar, expenses: allExpenses)
        
        calculateBalance()
        calculateExpense()
        calculateAppointmentsType()
    }
    
    public func addExpense() {
        coordinator?.addExpense()
    }
}

extension BalanceViewModel {
    
    private func calculateBalance() {
        var totalAmount: Double = 0
        
        for appointment in appointments {
            totalAmount += appointment.price
        }
        self.expectedBalance = String(format: "%.2f", totalAmount) + "€"
    }
    
    private func calculateExpense() {
        var totalAmount: Double = 0
        
        for item in expenses {
            totalAmount += item.amount
        }
        self.expense = String(format: "%.2f", totalAmount) + "€"
    }
    
    private func calculateAppointmentsType() {
        appointmentsType = appointments.map(\.type)
    }
}
