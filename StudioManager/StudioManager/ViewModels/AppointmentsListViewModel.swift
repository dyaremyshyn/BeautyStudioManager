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
