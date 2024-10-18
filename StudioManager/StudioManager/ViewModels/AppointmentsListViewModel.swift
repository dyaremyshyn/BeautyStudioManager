//
//  AppointmentsListViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import Foundation

class AppointmentsListViewModel: ObservableObject {
    private var allAppointments: [StudioAppointment] = []
    @Published private(set) var appointments: [StudioAppointment] = []
    @Published private(set) var errorMessage: String? = nil
    weak var coordinator: AppointmentsListCoordinator?
    
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
        filterAppointments()
        
    }
    
    public func filterAppointments(by filterCalendar: FilterCalendar = .today) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 3600)! // UTC+1
        calendar.locale = .current
        calendar.firstWeekday = 2 // Set the first weekday to Monday

        let now = Date()
        
        switch filterCalendar {
        case .today:
            // Start of today (ignores time)
            let startOfToday = calendar.startOfDay(for: now)
            let endOfToday = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
            appointments = allAppointments.filter { $0.date >= startOfToday && $0.date < endOfToday }
            
        case .week:
            // Start of the current week
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            let startOfWeekLocal = calendar.startOfDay(for: startOfWeek) // Start of the week at midnight
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeekLocal)! // End of the week
            appointments = allAppointments.filter { $0.date > startOfWeekLocal && $0.date <= endOfWeek }
            
        case .month:
            // Start of the current month
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            let startOfMonthLocal = calendar.startOfDay(for: startOfMonth) // Ensure it's local time
            let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonthLocal)!
            appointments = allAppointments.filter { $0.date >= startOfMonthLocal && $0.date < endOfMonth }
            
        case .all:
            appointments = allAppointments
        }
    }
    
    public func goToAppointmentDetails(appointment: StudioAppointment) {
        coordinator?.goToAppointmentDetails(appointment: appointment)
    }
    
    public func removeAppointment(index: Int) {
        let appointment = appointments[index]
        // First remove the appointment from persistence
        let success = persistenceService.deleteStudioAppointment(appointment: appointment)
        guard success else {
            errorMessage = "Erro ao apagar marcação"
            return
        }
        // Remove the appointment from both the current appointments array and the allAppointments array
        appointments.remove(at: index)
        if let allAppointmentsIndex = allAppointments.firstIndex(where: { $0.id == appointment.id }) {
            allAppointments.remove(at: allAppointmentsIndex)
        }
    }
}
