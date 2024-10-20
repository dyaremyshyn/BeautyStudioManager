//
//  AppointmentsListCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

class AppointmentsListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let viewController = AppointmentsComposer.appointmentsComposedWith(
            persistenceService: AppointmentPersistenceService()
        )
        viewController.viewModel?.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    public func goToAppointmentDetails(appointment: StudioAppointment) {
        let editAppointmentController = NewAppointmentComposer.newAppointmentComposedWith(
            appointment: appointment,
            persistenceLoader: AppointmentPersistenceService()
        )
        navigationController.pushViewController(editAppointmentController, animated: true)
    }
}
