//
//  ExpenseComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import Foundation
import SwiftUI

public final class ExpenseComposer {
    
    private init() {}
    
    public static func expenseComposedWith(expense: Expense?, persistenceLoader: ExpensePersistenceLoader) -> UIHostingController<ExpenseView> {
        let viewModel = ExpenseViewModel(expense: expense, persistenceService: persistenceLoader)
        let expenseView = ExpenseView(viewModel: viewModel)
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: expenseView)
        return hostingController
    }
}
