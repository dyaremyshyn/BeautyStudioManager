//
//  Coordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    /// Delegate to be triggered when a view controller's coordinator is disappearing to notify previous coordinator
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    /// Each coordinator has one navigation controller assigned to it.
    var navigationController: UINavigationController { get set }

    /// Array to keep tracking of all child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    /// Defined flow type.
    var type: CoordinatorType { get }

    func start()

    /// A place to put logic to finish the flow, to clean all children coordinators, and to notify the parent that this coordinator is ready to be deallocated
    func finish()
}

extension Coordinator {
    func finish() {
        /// For default stuff for completely reseting all flow
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - CoordinatorOutput

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType

enum CoordinatorType {
    /// for our example we will only have this ones but normally as the project gets bigger we will use more screens which means more coordinators. So the more cases should be added in that scenario.
    case app, mainTab, tabItem
}
