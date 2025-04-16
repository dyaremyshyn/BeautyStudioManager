//
//  ServicesListComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

final class ServiceListComposer {
    
    private init() {}
    
    static func servicesComposedWith(persistenceService: AppointmentServicePersistenceLoader, coordinator: ServicesListCoordinator) -> ServiceListViewController {
        let viewModel = ServiceListViewModel(persistenceService: persistenceService, coordinator: coordinator)
        let viewController = ServiceListViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension ServiceListViewController {
    static func makeWith(viewModel: ServiceListViewModel) -> ServiceListViewController {
        let viewController = ServiceListViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
