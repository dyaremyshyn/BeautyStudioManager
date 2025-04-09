//
//  OnboardingScreen.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 09/04/2025.
//

import SwiftUI

struct OnboardingScreen: View {
    @State private var currentPage = 0
    let description = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .Text.button
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingView(
                imageName: StudioTheme.agendaImage,
                title: tr.agendaTitle,
                description: description
            ).tag(0)
            OnboardingView(
                imageName: StudioTheme.balanceImage,
                title: tr.balanceTitle,
                description: description
            ).tag(1)
            OnboardingView(
                imageName: StudioTheme.newAppointmentImage,
                title: tr.newAppointmentTitle,
                description: description
            ).tag(2)
            OnboardingView(
                imageName: StudioTheme.servicesImage,
                title: tr.servicesTitle,
                description: description
            ).tag(3)
        }
        .tabViewStyle(.page)
        .padding()
        
        if currentPage == 3 {
            StudioButton(title: "Get Started", buttonType: .bottomPage, action: {})
                .transition(.opacity)
                .padding(.bottom)
        }
    }
}

#Preview {
    OnboardingScreen()
}
