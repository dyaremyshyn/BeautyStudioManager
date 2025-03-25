//
//  BalanceComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import SwiftUI

final class BalanceComposer {
    
    private init() {}
    
    static func balanceComposedWith(
        appointmentPersistenceService: AppointmentPersistenceLoader,
        expensePersistenceService: ExpensePersistenceLoader,
        coordinator: BalanceCoordinator? = nil
    ) -> UIHostingController<BalanceScreen> {
        let viewModel = BalanceViewModel(
            appointmentPersistenceService: appointmentPersistenceService,
            expensePersistenceService: expensePersistenceService
        )
        viewModel.coordinator = coordinator
        let balanceScreen = BalanceScreen(viewModel: viewModel)
        return UIHostingController(rootView: balanceScreen)
    }
}
