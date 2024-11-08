//
//  PricingTableViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

class PricingTableViewModel: ObservableObject {
    @Published private(set) var pricingTableList: [AppointmentTypeModel] = []
    @Published private(set) var errorMessage: String? = nil
    // Coordinator
    weak var coordinator: PricingTableCoordinator?
    // Services
    private let appointmentPersistenceService: AppointmentPersistenceLoader
    private let expensePersistenceService: ExpensePersistenceLoader

    init(appointmentPersistenceService: AppointmentPersistenceLoader, expensePersistenceService: ExpensePersistenceLoader) {
        self.appointmentPersistenceService = appointmentPersistenceService
        self.expensePersistenceService = expensePersistenceService
    }
    
    public func fetchData() {
        pricingTableList = AppointmentTypeModel.allPrices
        errorMessage = nil
    }
}
