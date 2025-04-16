//
//  SceneDelegate.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var appCoordinator: AppCoordinator = AppCoordinator(navigationController: UINavigationController())
    private lazy var onboardingSeen: Bool = UserDefaults.standard.bool(forKey: "onboardingSeen")
    private lazy var onboardingCoordinator: OnboardingCoordinator = OnboardingCoordinator(navigationController: UINavigationController())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if !onboardingSeen {
            onboardingCoordinator.start()
            window?.rootViewController = onboardingCoordinator.navigationController
        } else {
            appCoordinator.start()
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

