//
//  ExpenseListComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import SwiftUI

final class ExpenseListComposer {
    
    private init() {}
    
    static func expenseListComposedWith(persistenceService: ExpensePersistenceLoader, coordinator: ExpenseListCoordinator) -> UIHostingController<ExpenseListScreen> {
        let viewModel = ExpenseListViewModel(persistenceService: persistenceService)
        viewModel.coordinator = coordinator
        let screen = ExpenseListScreen(viewModel: viewModel)
        return UIHostingController(rootView: screen)
    }
}
