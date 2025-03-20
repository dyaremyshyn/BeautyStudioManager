//
//  AgendaCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

protocol AppointmentsListDelegate {
    func goToAppointmentDetails(appointment: StudioAppointment)
}

class AgendaCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var appointmentListViewController: AgendaViewController = {
        let viewController = AppointmentsComposer.appointmentsComposedWith(
            persistenceService: AppointmentPersistenceService()
        )
        viewController.viewModel?.coordinator = self
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(appointmentListViewController, animated: true)
    }
}

extension AgendaCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension AgendaCoordinator: AppointmentsListDelegate {
    
    public func goToAppointmentDetails(appointment: StudioAppointment) {
        let editAppointmentController = NewAppointmentComposer.newAppointmentComposedWith(
            appointment: appointment,
            appointmentsPersistenceService: AppointmentPersistenceService(),
            servicePersistenceService: AppointmentServicePersistenceService(), onNavigateToServiceList: {}
        )
        navigationController.pushViewController(editAppointmentController, animated: true)
        navigationController.topViewController?.title = tr.editAppointmentTitle
    }
}
