//
//  OnboardingScreen.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 09/04/2025.
//

import SwiftUI

struct OnboardingScreen: View {
    @StateObject var viewModel: OnboardingViewModel
    @State private var currentPage = 0

    init(viewModel: OnboardingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UIPageControl.appearance().currentPageIndicatorTintColor = .Text.button
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }
    
    var body: some View {
        VStack{
            TabView(selection: $currentPage) {
                OnboardingView(
                    imageName: StudioTheme.agendaImage,
                    title: tr.agendaTitle,
                    text: tr.onboardingAgendaDescription,
                    content: agendaContent
                ).tag(0)
                OnboardingView(
                    imageName: StudioTheme.balanceImage,
                    title: tr.balanceTitle,
                    text: tr.onboardingBalanceDescription,
                    content: { }
                ).tag(1)
                OnboardingView(
                    imageName: StudioTheme.newAppointmentImage,
                    title: tr.newAppointmentTitle,
                    text: tr.onboardingNewAppointmentDescription,
                    content: { }
                ).tag(2)
                OnboardingView(
                    imageName: StudioTheme.servicesImage,
                    title: tr.servicesTitle,
                    text: tr.onboardingServicesDescription,
                    content: servicesContent
                ).tag(3)
            }
            .tabViewStyle(.page)
            .padding()
            
            if currentPage == 3 {
                StudioButton(title: tr.getStartedTitle, buttonType: .bottomPage, action: viewModel.getStartedTapped)
                    .transition(.opacity)
                    .padding(.bottom)
            }
        }
        .navigationTitle(tr.onboardingTitle)
    }
}

private extension OnboardingScreen {
    @ViewBuilder func agendaContent() -> some View {
        HStack{
            Image(systemName: StudioTheme.addToCalendarImage)
                .renderingMode(.template)
                .foregroundStyle(Color.Text.button)
            Text(tr.onboardingAgendaCalendar)
                .font(.subheadline)
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder func servicesContent() -> some View {
        HStack{
            Image(systemName: StudioTheme.addServiceImage)
                .renderingMode(.template)
                .foregroundStyle(Color.Text.button)
            Text(tr.onboardingAddServiceDescription)
                .font(.subheadline)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    OnboardingScreen(viewModel: OnboardingViewModel())
}
