//
//  NewServiceViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/11/2024.
//

import Foundation

class NewServiceViewModel: ObservableObject {
    @Published var name: String!
    @Published var price: String!
    @Published var duration: Date!
    
    @Published private(set) var service: Service?
    private let persistenceService: AppointmentServicePersistenceLoader
    
    init(service: Service?, persistenceService: AppointmentServicePersistenceLoader) {
        self.service = service
        self.persistenceService = persistenceService
        resetAllFields()
        setFields(from: service)
    }
    
    public func saveService() {
        let service = Service(
            id: UUID(),
            type: name,
            price: Double(price) ?? 0,
            duration: duration.timeIntervalSince1970
        )
        
        // Save created service to core data
        persistenceService.save(service: service)
        
        // Reset all fields
        resetAllFields()
    }
    
    private func resetAllFields() {
        name = ""
        price = ""
        duration = Date(timeIntervalSince1970: 0)
    }
    
    private func setFields(from service: Service?) {
        guard let service else { return }
        name = service.type
        price = String(service.price)
        duration = Date(timeIntervalSince1970: service.duration)
    }
}
