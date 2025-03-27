//
//  ExpenseView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//

import SwiftUI

public struct ExpenseView: View {
    @StateObject var viewModel: ExpenseViewModel

    public var body: some View {
        ZStack(alignment: .bottom){
            Form {
                Section(tr.expenseDetails) {
                    textField(tr.expenseName, text: $viewModel.expenseName, errors: [.emptyName])
                    textField(tr.expensePrice, text: $viewModel.expensePrice, errors: [.emptyPrice])
                        .keyboardType(.numbersAndPunctuation)
                    StudioDatePicker(title: tr.date, selection: $viewModel.expenseDate, mode: .date)
                }
            }
            StudioButton(title: tr.save, enabled: viewModel.validationErrors.isEmpty, action: viewModel.saveExpense)
                .padding(.bottom, 20)
        }
        .toast(isVisible: $viewModel.showToast, text: tr.expenseAddedSuccessfully, image: StudioTheme.successImage)
    }
}

private extension ExpenseView {
    @ViewBuilder
    private func textField(_ title: String, text: Binding<String>, errors: [ExpenseValidationError] = []) -> some View {
        VStack(alignment: .leading) {
            TextField(title, text: text)
            if let firstError = errors.first(where: { viewModel.validationErrors.contains($0) }) {
                Text(firstError.translatedError)
                    .font(.caption)
                    .foregroundStyle(Color.Studio.warning)
                    .transition(.opacity)
            }
        }
    }
}

private extension ExpenseValidationError {
    var translatedError: String {
        switch self {
        case .emptyName: return tr.emptyName
        case .emptyPrice: return tr.emptyPrice
        }
    }
}

#Preview {
    ExpenseView(viewModel: ExpenseViewModel(persistenceService: ExpensePersistenceService()))
}
