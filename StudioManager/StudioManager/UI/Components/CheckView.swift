//
//  CheckView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 17/03/2025.
//

import SwiftUI

struct CheckView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
            .foregroundStyle(isChecked ? .green : .gray)
            .contentTransition(.symbolEffect)
            .onTapGesture {
                withAnimation {
                    isChecked.toggle()
                }
            }
    }
}

#Preview {
    @Previewable @State var isChecked = false
    CheckView(isChecked: $isChecked)
}
