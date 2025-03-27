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
        ZStack(alignment: .bottom) {
            if viewModel.expenses.isEmpty {
                StudioEmptyView(imageName: StudioTheme.emptyImage) {
                    Text(tr.emptyExpenseList)
                }
            } else {
                List {
                    ForEach(viewModel.groupedExpenses.keys.sorted(by: >), id: \.self) { year in
                        Section(year.description) {
                            let months = viewModel.groupedExpenses[year] ?? [:]
                            ForEach(months.keys.sorted(by: >), id: \.self) { month in
                                Section(header: Text(monthName(for: month)).foregroundStyle(.blue)) {
                                    ForEach(months[month] ?? []) { expense in
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
                        }
                    }
                }
            }
        }
        .navigationTitle(tr.expensesTitle)
        .onAppear(perform: viewModel.fetchData)
        .toast(isVisible: $viewModel.showToast, text: tr.errorDeletingExpense, type: .failure, image: StudioTheme.errorImage)
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
    
    func monthName(for month: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let monthSymbols = formatter.monthSymbols ?? []
        if month > 0, month <= monthSymbols.count {
            return monthSymbols[month - 1].capitalized
        }
        return "\(month)"
    }
}

#Preview {
    ExpenseListScreen(
        viewModel: ExpenseListViewModel(
            persistenceService: ExpensePersistenceService()
        )
    )
}
