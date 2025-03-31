//
//  ExpenseListCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 31/03/2025.
//

import Foundation
import UIKit
import SwiftUI

protocol ExpenseListDelegate {
    func editExpense(expense: Expense)
}

class ExpenseListCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var expenseService: ExpensePersistenceLoader = { ExpensePersistenceService() }()
    
    private lazy var expenseListController: UIHostingController<ExpenseListScreen> = {
        let viewController = ExpenseListComposer.expenseListComposedWith(
            persistenceService: expenseService,
            coordinator: self
        )
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(expenseListController, animated: true)
    }
}

extension ExpenseListCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension ExpenseListCoordinator: ExpenseListDelegate {
    
    func editExpense(expense: Expense) {
        let expenseViewController = ExpenseComposer.expenseComposedWith(
            expense: expense,
            persistenceLoader: expenseService
        )
        navigationController.pushViewController(expenseViewController, animated: true)
        navigationController.topViewController?.title = tr.expenseTitle
    }
}
