//
//  BalanceComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

public final class BalanceComposer {
    
    private init() {}
    
    public static func balanceComposedWith(persistenceService: AppointmentsPersistenceLoader) -> BalanceViewController {
        let viewModel = BalanceViewModel(persistenceService: persistenceService)
        let viewController = BalanceViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension BalanceViewController {
    static func makeWith(viewModel: BalanceViewModel) -> BalanceViewController {
        let viewController = BalanceViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
