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
                    TextField(tr.expenseName, text: $viewModel.expenseName)
                    TextField(tr.expensePrice, text: $viewModel.expenseAmount)
                        .keyboardType(.numbersAndPunctuation)
                    DatePicker(tr.date, selection: $viewModel.expenseDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            StudioButton(title: tr.save, action: viewModel.saveExpense)
                .padding(.horizontal)
                .padding(.bottom, 20)
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(viewModel: ExpenseViewModel(persistenceService: ExpensePersistenceService()))
    }
}
