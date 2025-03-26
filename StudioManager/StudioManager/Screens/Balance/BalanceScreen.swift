//
//  BalanceScreen.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 25/03/2025.
//

import SwiftUI
import Charts

struct BalanceScreen: View {
    @StateObject var viewModel: BalanceViewModel
    @State private var selectedFilter = FilterCalendar.today
    private let filters = [tr.filterToday, tr.filterWeek, tr.filterMonth, tr.filterYear]

    var body: some View {
        VStack {
            calendarFilterView()

            HStack(spacing: 20) {
                BalanceSectionView(title: tr.incomeTitle, type: .income, amount: $viewModel.income)
                BalanceSectionView(title: tr.expensesTitle, type: .expense, amount: $viewModel.expense)
            }
            .padding(.horizontal)
                        
            chartView()

            Spacer()
            
            HStack {
                StudioButton(title: tr.viewExpenses, icon: StudioTheme.listImage, buttonType: .secondary, action: viewModel.expenseListTapped)
                StudioButton(title: tr.addExpense, icon: StudioTheme.addImage,  buttonType: .secondary, destructive: true, action: viewModel.expenseListTapped)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle(tr.balanceTitle)
        .onChange(of: selectedFilter) { _, selectedFilter in
            viewModel.filterBalance(by: selectedFilter)
        }
        .onAppear {
            viewModel.fetchAppointments()
        }
    }
}

private extension BalanceScreen {
    @ViewBuilder func calendarFilterView() -> some View {
        Picker(tr.filterYear, selection: $selectedFilter) {
            Text(tr.filterToday).tag(FilterCalendar.today)
            Text(tr.filterWeek).tag(FilterCalendar.week)
            Text(tr.filterMonth).tag(FilterCalendar.month)
            Text(tr.filterYear).tag(FilterCalendar.all)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ViewBuilder func chartView() -> some View {
        if viewModel.servicesData.isEmpty {
            Spacer()
            Text(tr.noDataDescription)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        } else {
            Chart(viewModel.servicesData) { service in
                SectorMark(
                    angle: .value(tr.revenue, service.revenue),
                    innerRadius: .ratio(0.6),
                    angularInset: 2.0
                )
                .foregroundStyle(service.color)
            }
            .frame(height: 220)
            .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.servicesData) { service in
                    HStack {
                        Circle()
                            .fill(service.color)
                            .frame(width: 12, height: 12)
                        Text(formatServiceRevenue(service.service, service.revenue))
                            .font(.body)
                    }
                }
            }
        }
    }
    
    private func formatServiceRevenue(_ service: String, _ revenue: Double) -> String {
        String(format: "%@: €%.2f", service, revenue)
    }
}

#Preview {
    BalanceScreen(
        viewModel: BalanceViewModel(
            appointmentPersistenceService: AppointmentPersistenceService(),
            expensePersistenceService: ExpensePersistenceService()
        )
    )
}
