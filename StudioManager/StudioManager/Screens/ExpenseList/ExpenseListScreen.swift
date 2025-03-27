//
//  ExpenseListScreen.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import SwiftUI

struct ExpenseListScreen: View {
    @StateObject var viewModel: ExpenseListViewModel
    
    var body: some View {
        ZStack {
            if viewModel.expenses.isEmpty {
                StudioEmptyView(imageName: StudioTheme.emptyImage) {
                    Text(tr.emptyExpenseList)
                }
            } else {
                List(viewModel.expenses, id: \.self) { expense in
                    expenseRow(expense)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(tr.delete, role: .destructive) {
                                viewModel.deleteExpense(expense.id)
                            }
                        }
                }
            }
        }
        .navigationTitle(tr.expensesTitle)
        .onAppear(perform: viewModel.fetchData)
    }
}

private extension ExpenseListScreen {
    @ViewBuilder func expenseRow(_ expense: Expense) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.date.formatted())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(String(format: "%.2f€", expense.amount))
                .font(.subheadline)
                .foregroundStyle(Color.Studio.warning)
        }
    }
}

#Preview {
    ExpenseListScreen(
        viewModel: ExpenseListViewModel(
            persistenceService: ExpensePersistenceService()
        )
    )
}
