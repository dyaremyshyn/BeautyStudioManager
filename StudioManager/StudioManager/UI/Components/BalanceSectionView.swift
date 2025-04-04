//
//  BalanceSectionView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 25/03/2025.
//

import SwiftUI

enum BalanceType {
    case income
    case expense
    case balance
}

struct BalanceSectionView: View {
    let title: String
    let type: BalanceType
    @Binding var amount: String

    var body: some View {
        VStack {
            Text(formatAmount(amount))
                .font(.headline)
                .foregroundColor(type.color)
                .multilineTextAlignment(.center)
            Text(title)
                .font(.subheadline)
                .foregroundColor(type.color)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    private func formatAmount(_ amount: String) -> String {
        return String(format: "%@%@", type.prefix, amount)
    }
}

private extension BalanceType {
    var color: Color {
        switch self {
        case .income: return .Studio.success
        case .expense: return .Studio.warning
        case .balance: return .blue
        }
    }
    
    var prefix: String {
        switch self {
        case .income: return "+"
        case .expense: return "-"
        case .balance: return ""
        }
    }
}

#Preview {
    @Previewable @State var amount: String = "250€"
    BalanceSectionView(title: "Income", type: .income, amount: $amount)
    BalanceSectionView(title: "Expense", type: .expense, amount: $amount)
    BalanceSectionView(title: "Balance", type: .balance, amount: $amount)
}
