//
//  AppointmentsComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/10/2024.
//

import Foundation

public final class AppointmentsComposer {
    
    private init() {}
    
    public static func appointmentsComposedWith(persistenceService: AppointmentPersistenceLoader) -> AppointmentsListViewController {
        let viewModel = AppointmentsListViewModel(persistenceService: persistenceService)
        let viewController = AppointmentsListViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension AppointmentsListViewController {
    static func makeWith(viewModel: AppointmentsListViewModel) -> AppointmentsListViewController {
        let viewController = AppointmentsListViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
