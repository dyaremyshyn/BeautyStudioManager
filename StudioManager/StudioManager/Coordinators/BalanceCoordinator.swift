//
//  BalanceCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import Foundation
import UIKit
import SwiftUI

protocol BalanceDelegate {
    func addExpense()
    func viewExpenses()
    func compareBalances()
}

class BalanceCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var expenseService: ExpensePersistenceLoader = {
        ExpensePersistenceService()
    }()
    
    private lazy var balanceViewController: UIHostingController<BalanceScreen> = {
        let viewController = BalanceComposer.balanceComposedWith(
            appointmentPersistenceService: AppointmentPersistenceService(),
            expensePersistenceService: expenseService,
            coordinator: self
        )
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
    
    func addExpense() {
        let expenseViewController = ExpenseComposer.expenseComposedWith(
            expense: nil,
            persistenceLoader: expenseService
        )
        navigationController.pushViewController(expenseViewController, animated: true)
        navigationController.topViewController?.title = tr.expenseTitle
    }
    
    func viewExpenses() {
        let screen = ExpenseListComposer.expenseListComposedWith(
            persistenceService: expenseService,
            coordinator: ExpenseListCoordinator(navigationController: navigationController)
        )
        navigationController.pushViewController(screen, animated: true)
        navigationController.topViewController?.title = tr.expensesTitle
    }
    
    func compareBalances() {
        // TODO: 
    }
}
