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
        tabBarController.setValue(CustomTabBar(), forKey: "tabBar")
    }
    
    func start() {
        let pages: [TabBarPage] = [.agenda, .balance, .newAppointment, .services, .settings]

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
        case .settings:
            let coordinator = SettingsCoordinator(navigationController: navController)
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
        tabBarController.tabBar.tintColor = .Studio.items

        tabBarController.tabBar.tintColor = .Text.button
        tabBarController.tabBar.unselectedItemTintColor = .gray

        /// In this step, we attach tabBarController to navigation controller associated with this coordinator
        navigationController.viewControllers = [tabBarController]
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let tabBarItemView = viewController.tabBarItem.value(forKey: "view") as? UIView else { return }
        
        // Primeira etapa: aumenta e roda levemente
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            let rotationAngle = CGFloat.pi / 36 // 5 graus
            let scaleTransform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
            tabBarItemView.transform = scaleTransform.concatenating(rotationTransform)
        }, completion: { _ in
            // Segunda etapa: anima de volta à identidade com efeito de mola
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: { tabBarItemView.transform = CGAffineTransform.identity },
                completion: nil
            )
        })
    }
}

class CustomTabBar: UITabBar {
    private var topBorderLayer: CALayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.black.cgColor
        
        topBorderLayer?.removeFromSuperlayer()
        
        // Cria uma nova camada para a border no topo
        let borderHeight: CGFloat = 0.5
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: borderHeight)
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        
        layer.addSublayer(borderLayer)
        topBorderLayer = borderLayer
    }
}
