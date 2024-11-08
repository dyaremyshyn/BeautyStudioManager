//
//  PricingTableCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation
import UIKit

class PricingTableCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var balanceViewController: PricingTableViewController = {
        let viewController = PricingTableComposer.pricingTableComposedWith(
            appointmentPersistenceService: AppointmentPersistenceService(),
            expensePersistenceService: ExpensePersistenceService()
        )
        viewController.viewModel?.coordinator = self
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(balanceViewController, animated: true)
    }
}

extension PricingTableCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
