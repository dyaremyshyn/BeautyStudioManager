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
        filterAppointments(by: filterCalendar)
    }
    
    public func filterAppointments(by filterCalendar: FilterCalendar) {
        self.filterCalendar = filterCalendar
        appointments = FilterCalendarHelper.filter(by: filterCalendar, appointments: allAppointments)
        
        calculateBalance()
        calculateAppointmentsType()
    }
    
    public func addExpense() {
        coordinator?.addExpense()
    }
    
    private func calculateBalance() {
        var expectedBalance: Double = 0
        
        for appointment in appointments {
            expectedBalance += appointment.price
        }
        
        self.expectedBalance = String(format: "%.2f", expectedBalance) + "€"
    }
    
    private func calculateAppointmentsType() {
        appointmentsType = appointments.map(\.type)
    }
}
