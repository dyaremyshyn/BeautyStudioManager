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
        ScrollView {
            VStack(alignment: .leading) {
                setting(title: tr.appearanceTitle, image: .dark) {
                    viewModel.onAppearanceTapped()
                }
                
                setting(title: tr.currencyTitle, image: .dollarCircle) {
                    viewModel.onCurrencyTapped()
                }
            }
        }
        .navigationTitle(tr.settingsTitle)
    }
    
    @ViewBuilder private func setting(title: String, image: ImageResource, tap: @escaping () -> Void) -> some View {
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
            Image(.chevronRight)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .mediumSize()
                .foregroundStyle(Color.Text.button)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: StudioTheme.cr10)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
        .onTapGesture(perform: tap)
    }
}

#Preview {
    SettingsScreen(viewModel: SettingsViewModel())
}
