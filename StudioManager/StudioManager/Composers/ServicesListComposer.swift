//
//  ServicesListComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

public final class ServiceListComposer {
    
    private init() {}
    
    public static func servicesComposedWith(persistenceService: AppointmentServicePersistenceLoader) -> ServiceListViewController {
        let viewModel = ServiceListViewModel(persistenceService: persistenceService)
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
