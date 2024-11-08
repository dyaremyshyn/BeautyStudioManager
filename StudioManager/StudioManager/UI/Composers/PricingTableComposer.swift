//
//  PricingTableComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation

public final class PricingTableComposer {
    
    private init() {}
    
    public static func pricingTableComposedWith(
        appointmentPersistenceService: AppointmentPersistenceLoader,
        expensePersistenceService: ExpensePersistenceLoader
    ) -> PricingTableViewController {
        let viewModel = PricingTableViewModel(appointmentPersistenceService: appointmentPersistenceService, expensePersistenceService: expensePersistenceService)
        let viewController = PricingTableViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension PricingTableViewController {
    static func makeWith(viewModel: PricingTableViewModel) -> PricingTableViewController {
        let viewController = PricingTableViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
