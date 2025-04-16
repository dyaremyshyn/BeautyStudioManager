//
//  OnboardingViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 11/04/2025.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    weak var coordinator: OnboardingCoordinator?

    init() { }
        
    func getStartedTapped() {
        UserDefaults.standard.set(true, forKey: "onboardingSeen")
        coordinator?.getStarted()
    }
}
