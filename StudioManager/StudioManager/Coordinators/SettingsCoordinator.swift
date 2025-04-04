//
//  SettingsCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 04/04/2025.
//

import Foundation
import UIKit
import SwiftUI

class SettingsCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var expenseService: ExpensePersistenceLoader = {
        ExpensePersistenceService()
    }()
    
    private lazy var settingsViewController: UIHostingController<SettingsScreen> = {
        SettingsComposer.composedWith(coordinator: self)
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}

extension SettingsCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
