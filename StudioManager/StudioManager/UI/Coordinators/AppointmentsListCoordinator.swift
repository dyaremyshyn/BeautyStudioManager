//
//  AppointmentsListCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

protocol AppointmentsListDelegate {
    func goToAppointmentDetails(appointment: StudioAppointment)
}

class AppointmentsListCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var appointmentListViewController: AppointmentsListViewController = {
        let viewController = AppointmentsComposer.appointmentsComposedWith(
            persistenceService: AppointmentPersistenceService()
        )
        viewController.viewModel?.coordinator = self
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        navigationController.pushViewController(appointmentListViewController, animated: true)
    }
}

extension AppointmentsListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension AppointmentsListCoordinator: AppointmentsListDelegate {
    
    public func goToAppointmentDetails(appointment: StudioAppointment) {
        let editAppointmentController = NewAppointmentComposer.newAppointmentComposedWith(
            appointment: appointment,
            persistenceLoader: AppointmentPersistenceService()
        )
        navigationController.pushViewController(editAppointmentController, animated: true)
    }
}
