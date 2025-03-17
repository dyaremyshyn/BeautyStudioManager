//
//  ServicesListComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

public final class ServicesListComposer {
    
    private init() {}
    
    public static func servicesComposedWith(persistenceService: AppointmentServicePersistenceLoader) -> ServicesListViewController {
        let viewModel = ServicesListViewModel(persistenceService: persistenceService)
        let viewController = ServicesListViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension ServicesListViewController {
    static func makeWith(viewModel: ServicesListViewModel) -> ServicesListViewController {
        let viewController = ServicesListViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
