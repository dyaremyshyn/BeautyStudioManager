//
//  TabCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/10/2024.
//

import Foundation
import UIKit

class TabCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorType { .mainTab }
    
    let servicePersistenceService: AppointmentServicePersistenceLoader

    init(navigationController: UINavigationController, servicePersistenceService: AppointmentServicePersistenceLoader) {
        self.navigationController = navigationController
        self.servicePersistenceService = servicePersistenceService
        tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPage] = [.agenda, .newAppointment, .balance, .services]

        // Initialization of ViewControllers from pages
        let controllers: [UINavigationController] = pages.map { getTabController($0) }

        prepareTabBarController(withTabControllers: controllers)
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(
            title: page.getTitleName(),
            image: UIImage(systemName: page.getIconName()),
            tag: page.getIndex()
        )
        switch page {
        case .agenda:
            let coordinator = AgendaCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .newAppointment:
            let coordinator = NewAppointmentCoordinator(navigationController: navController, servicePersistenceService: servicePersistenceService)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .balance:
            let coordinator = BalanceCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .services:
            let coordinator = ServicesListCoordinator(navigationController: navController, servicePersistenceService: servicePersistenceService)
            coordinator.start()
            childCoordinators.append(coordinator)
            
        }
        return navController
    }
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.agenda.getIndex()
        tabBarController.tabBar.isTranslucent = false

        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}
