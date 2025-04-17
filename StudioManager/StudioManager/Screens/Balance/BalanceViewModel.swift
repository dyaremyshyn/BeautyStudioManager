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
    @Published var income: String = ""
    @Published var expense: String = ""
    @Published var balance: String = ""
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var servicesData: [ServiceRevenue] = []
    private var filterCalendar: FilterCalendar = .today
    // Coordinator
    private var coordinator: BalanceCoordinator
    // Services
    private let appointmentPersistenceService: AppointmentPersistenceLoader
    private let expensePersistenceService: ExpensePersistenceLoader

    init(appointmentPersistenceService: AppointmentPersistenceLoader, expensePersistenceService: ExpensePersistenceLoader, coordinator: BalanceCoordinator) {
        self.appointmentPersistenceService = appointmentPersistenceService
        self.expensePersistenceService = expensePersistenceService
        self.coordinator = coordinator
    }
    
    func fetchAppointments() {
        allAppointments = appointmentPersistenceService.fetchAll()
        allExpenses = expensePersistenceService.fetchAll()
        errorMessage = nil
        filterBalance(by: filterCalendar)
    }
    
    func filterBalance(by filterCalendar: FilterCalendar) {
        self.filterCalendar = filterCalendar
        appointments = FilterCalendarHelper.filterBalance(by: filterCalendar, appointments: allAppointments)
        expenses = FilterCalendarHelper.filterExpense(by: filterCalendar, expenses: allExpenses)
        
        calculateBalance()
        mapAppointmentsToTypeAmount()
    }
    
    func addExpense() {
        coordinator.addExpense()
    }
    
    func expenseListTapped() {
        coordinator.viewExpenses()
    }
    
    func compareBalanceTapped() {
        coordinator.compareBalances()
    }
}

private extension BalanceViewModel {
    
    func calculateBalance() {
        income = CalculateBalanceHelper.calculateIncome(appointments: appointments)
        expense = CalculateBalanceHelper.calculateExpense(expenses: expenses)
        balance = CalculateBalanceHelper.calculateBalance(appointments: appointments, expenses: expenses)
    }
        
    func mapAppointmentsToTypeAmount() {
        servicesData.removeAll()
        for appointment in appointments {
            if let index = servicesData.firstIndex(where: { $0.service == appointment.type }) {
                servicesData[index].revenue += appointment.price
            } else {
                servicesData.append(ServiceRevenue(service: appointment.type, revenue: appointment.price, color: appointment.color))
            }
        }
    }
}
