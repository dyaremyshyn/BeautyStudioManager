//
//  MainCoordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    public lazy var tabBarController = UITabBarController()
    private lazy var appointmentsListCoordinator = AppointmentsListCoordinator(navigationController: navigationController)

    private lazy var newAppointmentViewController = UINavigationController(
        rootViewController: NewAppointmentComposer.newAppointmentComposedWith(
            appointment: nil,
            persistenceLoader: PersistenceService()
        )
    )
    
    private lazy var balanceViewController = UINavigationController(
        rootViewController: UIViewController()
    )
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func configureTabBar() {
        let appointmentsNavController = appointmentsListCoordinator.navigationController
        appointmentsNavController.navigationBar.prefersLargeTitles = true
        appointmentsNavController.tabBarItem = UITabBarItem(title: "Marcações", image: UIImage(systemName: "list.bullet.clipboard"), tag: 0)
        
        newAppointmentViewController.tabBarItem = UITabBarItem(title: "Nova Marcação", image: UIImage(systemName: "plus.circle"), tag: 1)
        
        balanceViewController.navigationBar.prefersLargeTitles = true
        balanceViewController.tabBarItem = UITabBarItem(title: "Balanço", image: UIImage(systemName: "chart.xyaxis.line"), tag: 2)
        
        tabBarController.viewControllers = [appointmentsNavController, newAppointmentViewController, balanceViewController]
    }
    
    public func start() {
        appointmentsListCoordinator.start()
        childCoordinators.append(appointmentsListCoordinator)

        configureTabBar()
    }
}
