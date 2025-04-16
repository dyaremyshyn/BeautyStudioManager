//
//  OnboardingCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 11/04/2025.
//

import Foundation
import UIKit
import SwiftUI

protocol OnboardingDelegate {
    func getStarted()
}

class OnboardingCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabItem
    
    private lazy var expenseService: ExpensePersistenceLoader = {
        ExpensePersistenceService()
    }()
    
    private lazy var onboardingViewController: UIHostingController<OnboardingScreen> = {
        let viewController = OnboardingComposer.composedWith(coordinator: self)
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
}

extension OnboardingCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension OnboardingCoordinator: OnboardingDelegate {
    func getStarted() {
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator.start()
        self.navigationController.setViewControllers(appCoordinator.navigationController.viewControllers, animated: true)
    }
}
