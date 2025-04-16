//
//  ServiceListViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

class ServiceListViewModel: ObservableObject {
    @Published private(set) var services: [Service] = []
    @Published private(set) var errorMessage: String? = nil
    // Coordinator
    private var coordinator: ServicesListCoordinator
    // Services
    private let persistenceService: AppointmentServicePersistenceLoader

    init(persistenceService: AppointmentServicePersistenceLoader, coordinator: ServicesListCoordinator) {
        self.persistenceService = persistenceService
        self.coordinator = coordinator
    }
    
    public func fetchData() {
        services = persistenceService.fetchAll().sorted { $0.type < $1.type }
        errorMessage = nil
    }
    
    public func serviceTapped(_ service: Service) {
        coordinator.goToService(service: service)
    }
    
    public func addService() {
        coordinator.goToService(service: nil)
    }
    
    public func removeService(index: Int) {
        let service = services[index]
        // First remove from persistence
        let success = persistenceService.delete(service: service)
        guard success else {
            errorMessage = tr.serviceDeleteErrorMessage
            return
        }
        // Remove service
        services.remove(at: index)
    }
}
