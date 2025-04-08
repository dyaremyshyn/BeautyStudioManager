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
    weak var coordinator: ServicesListCoordinator?
    // Services
    private let persistenceService: AppointmentServicePersistenceLoader

    init(persistenceService: AppointmentServicePersistenceLoader) {
        self.persistenceService = persistenceService
    }
    
    public func fetchData() {
        services = persistenceService.fetchAll().sorted { $0.type < $1.type }
        errorMessage = nil
    }
    
    public func serviceTapped(_ service: Service) {
        coordinator?.goToService(service: service)
    }
    
    public func addService() {
        coordinator?.goToService(service: nil)
    }
    
    public func removeService(index: Int) {
        let service = services[index]
        // First remove from persistence
        let success = persistenceService.delete(service: service)
        guard success else {
            errorMessage = "Erro ao apagar serviço"
            return
        }
        // Remove service
        services.remove(at: index)
    }
}
