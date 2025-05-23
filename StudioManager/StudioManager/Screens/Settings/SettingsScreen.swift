//
//  SettingsScreen.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 04/04/2025.
//

import SwiftUI

struct SettingsScreen: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            Section {
                appearance()
                currency()
            }
            
            notifications()
        }
        .navigationTitle(tr.settingsTitle)
    }
}

private extension SettingsScreen {
    @ViewBuilder func appearance() -> some View {
        NavigationLink(destination: Text(tr.appearanceTitle)) {
            setting(title: tr.appearanceTitle, image: .dark, value: "System") {
                viewModel.onAppearanceTapped()
            }
        }
    }
    
    @ViewBuilder func currency() -> some View {
        NavigationLink(destination: Text(tr.appearanceTitle)) {
            setting(title: tr.currencyTitle, image: .dollarCircle, value: "EUR") {
                viewModel.onCurrencyTapped()
            }
        }
    }
    
    @ViewBuilder func notifications() -> some View {
        Section {
            NavigationLink(destination: Text("Notifications")) {
                Text("Notifications")
            }
        } footer: {
            Text("Customize if you wanna be remembered to add new appointments to the app.")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder func setting(title: String, image: ImageResource, value: String = "", tap: @escaping () -> Void) -> some View {
        HStack {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .mediumSize()
                .foregroundStyle(Color.Text.button)
            Text(title)
                .font(.callout)
            Spacer()
            Text(value)
                .font(.callout)
                .foregroundStyle(.gray)
        }
        .onTapGesture(perform: tap)
    }
}

#Preview {
    NavigationView{
        SettingsScreen(viewModel: SettingsViewModel())
    }
}
