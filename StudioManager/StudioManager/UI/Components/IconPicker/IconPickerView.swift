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
                    VStack(alignment: .leading, spacing: 24) {
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
                                .frame(width: 60, height: 60)
                                .background(.ultraThinMaterial, in: Circle())
                            }
                        }
                    }
                    .safeAreaPadding(.leading)
                }
                
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
                                    .frame(width: 60, height: 60)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                        }
                    }
                }
                .searchable(text: $pickerSearchText)
                .safeAreaPadding()
            }
        }
        .navigationTitle(tr.iconsTitle)
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var viewModel: IconPickerViewModel = IconPickerViewModel()
    @Previewable @State var selectedIcon: String = ""
    IconPickerView(viewModel: $viewModel, selectedIcon: $selectedIcon)
}
