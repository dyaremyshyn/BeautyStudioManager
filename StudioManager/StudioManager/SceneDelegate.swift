//
//  SceneDelegate.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var navigationController: UINavigationController = UINavigationController()
    private lazy var onboardingSeen: Bool = UserDefaults.standard.bool(forKey: "onboardingSeen")
    private lazy var appCoordinator: AppCoordinator = {
        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()
        return coordinator
    }()
    private lazy var onboardingCoordinator: OnboardingCoordinator = {
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.start()
        return coordinator
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if !onboardingSeen {
            window?.rootViewController = onboardingCoordinator.navigationController
        } else {
            window?.rootViewController = appCoordinator.navigationController
        }
        window?.makeKeyAndVisible()
    }
    

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

