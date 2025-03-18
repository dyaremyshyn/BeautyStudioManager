//
//  ServicesListCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation
import UIKit

protocol ServicesListDelegate {
    func goToService(service: Service?)
}

class ServicesListCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private let servicePersistenceService: AppointmentServicePersistenceLoader
    
    private lazy var balanceViewController: ServiceListViewController = {
        let viewController = ServiceListComposer.servicesComposedWith(persistenceService: servicePersistenceService)
        viewController.viewModel?.coordinator = self
        return viewController
    }()
    
    init(navigationController: UINavigationController, servicePersistenceService: AppointmentServicePersistenceLoader) {
        self.navigationController = navigationController
        self.servicePersistenceService = servicePersistenceService
    }
    
    func start() {
        navigationController.pushViewController(balanceViewController, animated: true)
    }
}

extension ServicesListCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension ServicesListCoordinator: ServicesListDelegate {
    func goToService(service: Service?) {
        let editServiceController = NewServiceComposer.newServiceComposedWith(
            service: service,
            persistenceLoader: servicePersistenceService
        )
        navigationController.pushViewController(editServiceController, animated: true)
        navigationController.topViewController?.title = service == nil ? "Novo serviço" : "Editar serviço"
    }
}
