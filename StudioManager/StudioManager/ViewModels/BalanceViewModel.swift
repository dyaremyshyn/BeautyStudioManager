//
//  BalanceViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import Foundation

class BalanceViewModel: ObservableObject {
    private var allAppointments: [StudioAppointment] = []
    private var appointments: [StudioAppointment] = []
    @Published private(set) var appointmentsType: [AppointmentType] = []
    @Published private(set) var expectedBalance: String = ""
    @Published private(set) var errorMessage: String? = nil
    private var filterCalendar: FilterCalendar = .today

    private let persistenceService: PersistenceLoader

    init(persistenceService: PersistenceLoader) {
        self.persistenceService = persistenceService
    }
    
    public func fetchAppointments() {
        allAppointments = persistenceService.getStudioAppointments()
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
