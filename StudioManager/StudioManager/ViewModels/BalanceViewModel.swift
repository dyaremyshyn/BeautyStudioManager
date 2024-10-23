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
    // Properties
    @Published private(set) var appointmentsType: [AppointmentType] = []
    @Published private(set) var expectedBalance: String = ""
    @Published private(set) var expense: String = ""
    @Published private(set) var errorMessage: String? = nil
    private var filterCalendar: FilterCalendar = .today
    // Coordinator
    weak var coordinator: BalanceCoordinator?
    // Services
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
        self.expectedBalance = CalculateBalanceHelper.calculateBalance(appointments: appointments)
    }
    
    private func calculateExpense() {
        self.expense = CalculateBalanceHelper.calculateExpense(expenses: expenses)
    }
    
    private func calculateAppointmentsType() {
        appointmentsType = appointments.map(\.type)
    }
}
