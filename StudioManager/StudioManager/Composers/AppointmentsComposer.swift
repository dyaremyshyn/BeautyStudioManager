//
//  AppointmentsComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/10/2024.
//

import Foundation

public final class AppointmentsComposer {
    
    private init() {}
    
    public static func appointmentsComposedWith(persistenceService: AppointmentPersistenceLoader) -> AgendaViewController {
        let viewModel = AgendaViewModel(persistenceService: persistenceService)
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
