//
//  OnboardingComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 11/04/2025.
//

import SwiftUI

final class OnboardingComposer {
    
    private init() {}
    
    static func composedWith(coordinator: OnboardingCoordinator?) -> UIHostingController<OnboardingScreen> {
        let viewModel = OnboardingViewModel()
        viewModel.coordinator = coordinator
        let screen = OnboardingScreen(viewModel: viewModel)
        return UIHostingController(rootView: screen)
    }
}
