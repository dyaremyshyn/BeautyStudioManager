//
//  IconPickerView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var viewModel: IconPickerViewModel
    @Binding var selectedIcon: String
    @Environment(\.dismiss) var dismiss
    @State private var pickerSearchText: String = ""
    
    var body: some View {
        NavigationStack{
            ScrollView {
                if !viewModel.inputIcons.isEmpty {
                    suggestionsSection()
                }
                
                filteredSections()
                    .searchable(text: $pickerSearchText)
                    .safeAreaPadding()
            }
        }
        .navigationTitle(tr.iconsTitle)
        .padding(.horizontal)
    }
}

private extension IconPickerView {
    @ViewBuilder func filteredSections() -> some View {
        VStack(alignment: .leading) {
            let filteredSections = viewModel.filteredSections(searchText: pickerSearchText)
            ForEach(filteredSections.keys.sorted(), id: \.self) { section in
                Text(section)
                    .font(.headline)
                    .padding(.leading)
                    .padding(.top)
                LazyVGrid(columns: Array(repeating: GridItem(), count: 5)) {
                    ForEach(filteredSections[section] ?? [], id: \.self) { icon in
                        Image(icon)
                            .padding(10)
                            .font(.system(size: 20))
                            .onTapGesture {
                                selectedIcon = icon
                                dismiss()
                            }
                            .veryBigSize()
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
            }
        }
    }
    
    @ViewBuilder func suggestionsSection() -> some View {
        VStack(alignment: .leading, spacing: StudioTheme.spacing24) {
            Text(tr.suggestionsSubtitle)
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.inputIcons, id: \.self) { icon in
                        Image(icon)
                            .padding(10)
                            .font(.system(size: 20))
                            .onTapGesture {
                                selectedIcon = icon
                                dismiss()
                            }
                    }
                    .veryBigSize()
                    .background(.ultraThinMaterial, in: Circle())
                }
            }
        }
        .safeAreaPadding(.leading)
    }
}

#Preview {
    @Previewable @State var viewModel: IconPickerViewModel = IconPickerViewModel()
    @Previewable @State var selectedIcon: String = ""
    IconPickerView(viewModel: $viewModel, selectedIcon: $selectedIcon)
}
