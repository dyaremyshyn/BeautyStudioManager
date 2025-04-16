//
//  AppointmentsComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/10/2024.
//

import Foundation

final class AppointmentsComposer {
    
    private init() {}
    
    static func appointmentsComposedWith(persistenceService: AppointmentPersistenceLoader, coordinator: AgendaCoordinator) -> AgendaViewController {
        let viewModel = AgendaViewModel(persistenceService: persistenceService, coordinator: coordinator)
        let viewController = AgendaViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension AgendaViewController {
    static func makeWith(viewModel: AgendaViewModel) -> AgendaViewController {
        let viewController = AgendaViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
