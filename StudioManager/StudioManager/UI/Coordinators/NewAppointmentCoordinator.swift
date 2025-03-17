//
//  NewAppointmentCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/10/2024.
//

import Foundation
import UIKit
import SwiftUI

class NewAppointmentCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    private let servicePersistenceService: AppointmentServicePersistenceLoader

    private lazy var newAppointmentViewController: UIHostingController<NewAppointmentView> = {
        let viewController = NewAppointmentComposer.newAppointmentComposedWith(
            appointment: nil,
            appointmentsPersistenceService: AppointmentPersistenceService(),
            servicePersistenceService: servicePersistenceService
        )
        return viewController
    }()
    
    init(navigationController: UINavigationController, servicePersistenceService: AppointmentServicePersistenceLoader) {
        self.navigationController = navigationController
        self.servicePersistenceService = servicePersistenceService
    }
    
    func start() {
        navigationController.pushViewController(newAppointmentViewController, animated: true)
        navigationController.topViewController?.title = "Nova marcação"        
    }
}

extension NewAppointmentCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
