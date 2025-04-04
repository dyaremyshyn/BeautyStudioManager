//
//  AgendaViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import Foundation

class AgendaViewModel: ObservableObject {
    private var allAppointments: [StudioAppointment] = []
    @Published private(set) var appointments: [StudioAppointment] = []
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var successMessage: String? = nil
    weak var coordinator: AgendaCoordinator?
    private var filterCalendar: FilterCalendar = .today
    
    private let persistenceService: AppointmentPersistenceLoader
    
    init(persistenceService: AppointmentPersistenceLoader) {
        self.persistenceService = persistenceService
    }
    
    public func fetchAppointments() {
        allAppointments = persistenceService.fetchAll()
        errorMessage = nil
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
        
        // Remove calendar event
        CalendarService.deleteEvent(eventId: appointment.calendarEventId)
        
        // First remove the appointment from persistence
        let success = persistenceService.delete(appointment: appointment)
        guard success else {
            errorMessage = tr.errorDeletingAppointment
            return
        }
        // Remove the appointment from both the current appointments array and the allAppointments array
        appointments.remove(at: index)
        if let allAppointmentsIndex = allAppointments.firstIndex(where: { $0.id == appointment.id }) {
            allAppointments.remove(at: allAppointmentsIndex)
        }
    }
    
    public func addAppointmentsToCalendar() {
        let addCalendarAppointments = allAppointments.filter { !$0.addedToCalendar }
        self.successMessage = addCalendarAppointments.isEmpty ? tr.noAppointmentsToAddToCalendar : nil
        addCalendarAppointments.forEach { appointment in
            CalendarService.createEvent(to: appointment) { [weak self] result in
                self?.errorMessage = result == nil ? tr.errorAddingAppointmentToCalendar : nil
                self?.successMessage = result != nil ? tr.appointmentsAddedToCalendar : nil
                self?.appointmentsAddedToCalendar(appointment: appointment, index: self?.allAppointments.firstIndex(where: { $0.id == appointment.id }), eventId: result)
            }
        }
    }
    
    private func appointmentsAddedToCalendar(appointment: StudioAppointment, index: Int?, eventId: String?) {
        guard let index else { return }
        let updatedAppointment = StudioAppointment(
            id: appointment.id,
            date: appointment.date,
            price: appointment.price,
            type: appointment.type,
            inResidence: appointment.inResidence,
            name: appointment.name,
            phoneNumber: appointment.phoneNumber,
            duration: appointment.duration,
            addedToCalendar: true,
            icon: appointment.icon,
            color: appointment.color,
            calendarEventId: eventId
        )
        self.allAppointments[index] = updatedAppointment
        filterAppointments(by: filterCalendar)
        persistenceService.add(appointment: updatedAppointment)
    }
}
