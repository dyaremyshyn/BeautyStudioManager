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
}

struct BalanceSectionView: View {
    let title: String
    let type: BalanceType
    @Binding var amount: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(type == .income ? .Studio.success : .Studio.warning)
                .multilineTextAlignment(.center)
            Text(amount)
                .font(.title)
                .foregroundColor(type == .income ? .Studio.success : .Studio.warning)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var amount: String = "250€"
    BalanceSectionView(title: "Income", type: .income, amount: $amount)
}
