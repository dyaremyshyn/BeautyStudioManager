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
        NavigationView {
            Form {
                Section {
                    TextField("Nome", text: $viewModel.expenseName)
                    TextField("Valor", text: $viewModel.expenseAmount)
                        .keyboardType(.numbersAndPunctuation)
                    DatePicker("Data", selection: $viewModel.expenseDate, displayedComponents: [.date, .hourAndMinute])
                } header: {
                    Text("Detalhes da despesa")
                }
                Button(action: {
                    viewModel.saveExpense()
                }, label: {
                    Text("Guardar")
                        .foregroundColor(.blue)
                })
                .frame(width: 400, height: 30, alignment: .center)
            }
            .navigationBarTitle("Despesa")
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(viewModel: ExpenseViewModel(persistenceService: ExpensePersistenceService()))
    }
}
