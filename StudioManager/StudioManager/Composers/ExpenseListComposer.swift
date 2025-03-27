//
//  ExpenseListComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import SwiftUI

final class ExpenseListComposer {
    
    private init() {}
    
    static func expenseListComposedWith(persistenceService: ExpensePersistenceLoader) -> UIHostingController<ExpenseListScreen> {
        let viewModel = ExpenseListViewModel(persistenceService: persistenceService)
        let screen = ExpenseListScreen(viewModel: viewModel)
        return UIHostingController(rootView: screen)
    }
}
