//
//  BalanceCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import Foundation
import UIKit

protocol BalanceDelegate {
    func addExpense()
}

class BalanceCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var balanceViewController: BalanceViewController = {
        let viewController = BalanceComposer.balanceComposedWith(
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

extension BalanceCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension BalanceCoordinator: BalanceDelegate {
    
    public func addExpense() {
        let expenseViewController = ExpenseComposer.expenseComposedWith(
            persistenceLoader: ExpensePersistenceService()
        )
        navigationController.pushViewController(expenseViewController, animated: true)
    }
}
