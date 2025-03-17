//
//  AppCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/10/2024.
//

import Foundation
import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }

    let sharedServicePersistence = AppointmentServicePersistenceService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showMainFlow()
    }

    func showMainFlow() {
        let tabCoordinator = TabCoordinator(
            navigationController: navigationController,
            servicePersistenceService: sharedServicePersistence
        )
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        // Do additional stuff after the presented screen is dismissed 
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
