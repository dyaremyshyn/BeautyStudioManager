//
//  AppointmentsListViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import Foundation

class AppointmentsListViewModel: ObservableObject {
    @Published private(set) var appointments: [StudioAppointment] = []
    @Published private(set) var errorMessage: String? = nil
    
    private let persistenceService: PersistenceLoader
    
    init(persistenceService: PersistenceLoader) {
        self.persistenceService = persistenceService
    }
    
    public func fetchAppointments() {
        appointments = persistenceService.getStudioAppointments()
        errorMessage = nil
        
#if DEBUG
        appointments = appointments.count == 0 ? Appointment.allCustomers : appointments
#endif
    }
}
