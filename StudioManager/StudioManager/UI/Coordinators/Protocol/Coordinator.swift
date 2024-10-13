//
//  Coordinator.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 12/10/2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    /// Each coordinator has one navigation controller assigned to it.
    var navigationController: UINavigationController { get set }

    /// Array to keep tracking of all child coordinators.
    var childCoordinators: [Coordinator] { get set }

    func start()
}
