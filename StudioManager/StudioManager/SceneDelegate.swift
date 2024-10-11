//
//  SceneDelegate.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var appointmentsListController = UINavigationController(
        rootViewController: AppointmentsComposer.appointmentsComposedWith(
            persistenceService: PersistenceService()
        )
    )
    
    private lazy var newAppointmentViewController = UINavigationController(
        rootViewController: NewAppointmentComposer.newAppointmentComposedWith(
            appointment: nil,
            persistenceLoader: PersistenceService()
        )
    )
    
    private lazy var balanceViewController = UINavigationController(
        rootViewController: UIViewController()
    )
    
    private lazy var tabBarController = UITabBarController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        configureTabBar()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func configureTabBar() {
        appointmentsListController.navigationBar.prefersLargeTitles = true
        appointmentsListController.tabBarItem = UITabBarItem(title: "Marcações", image: UIImage(systemName: "list.bullet.clipboard"), tag: 0)
        newAppointmentViewController.tabBarItem = UITabBarItem(title: "Nova Marcação", image: UIImage(systemName: "plus.circle"), tag: 1)
        balanceViewController.tabBarItem = UITabBarItem(title: "Balanço", image: UIImage(systemName: "chart.xyaxis.line"), tag: 2)
        tabBarController.viewControllers = [appointmentsListController, newAppointmentViewController, balanceViewController]
    }

    private func navigateToAppointmentDetail(appointment: StudioAppointment) {
        let hostingController = NewAppointmentComposer.newAppointmentComposedWith(appointment: appointment, persistenceLoader: PersistenceService())
        if let selectedViewController = tabBarController.selectedViewController as? UINavigationController {
            selectedViewController.pushViewController(hostingController, animated: true)
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

