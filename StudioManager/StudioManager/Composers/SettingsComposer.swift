//
//  SettingsComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 04/04/2025.
//

import SwiftUI

final class SettingsComposer {
    
    private init() {}
    
    static func composedWith(coordinator: SettingsCoordinator?) -> UIHostingController<SettingsScreen> {
        let viewModel = SettingsViewModel()
        viewModel.coordinator = coordinator
        let rootView = SettingsScreen(viewModel: viewModel)
        return UIHostingController(rootView: rootView)
    }
}
