//
//  NewServiceView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/11/2024.
//

import SwiftUI

public struct NewServiceView: View {
    @StateObject var viewModel: NewServiceViewModel
    @State private var pickerViewModel = IconPickerViewModel()
    @State private var showIconPicker: Bool = false

    public var body: some View {
        ZStack(alignment: .bottom){
            Form {
                Section(tr.serviceDetails) {
                    HStack{
                        Image(viewModel.icon)
                            .font(.title)
                            .frame(width: 55, height: 55)
                            .background(.ultraThinMaterial, in: Circle())
                            .onTapGesture {
                                showIconPicker = true
                            }
                        textField(tr.serviceName, text: $viewModel.name, errors: [.emptyName])
                            .onChange(of: viewModel.name) { _, _ in
                                pickerViewModel.searchText = viewModel.name
                                if let matchedIcon = pickerViewModel.iconFilter.first {
                                    viewModel.icon = matchedIcon
                                    if !pickerViewModel.inputIcons.contains(matchedIcon) {
                                        pickerViewModel.inputIcons.append(matchedIcon)
                                    }
                                } else {
                                    viewModel.icon = StudioTheme.serviceDefaultImage
                                }
                            }
                    }
                    textField(tr.servicePrice, text: $viewModel.price, errors: [.emptyPrice])
                        .keyboardType(.numbersAndPunctuation)
                    datePicker(tr.serviceDuration, selection: $viewModel.duration, errors: [.invalidDuration])
                }
            }
            StudioButton(title: tr.save, enabled: viewModel.validationErrors.isEmpty, action: viewModel.saveService)
                .padding(.bottom, 20)
        }
        .toast(isVisible: $viewModel.showToast, text: tr.serviceAddedSuccessfully, image: StudioTheme.successImage)
        .sheet(isPresented: $showIconPicker) {
            IconPickerView(viewModel: $pickerViewModel, selectedIcon: $viewModel.icon)
        }
    }
}

private extension NewServiceView {
    @ViewBuilder
    private func textField(_ title: String, text: Binding<String>, errors: [ServiceValidationError] = []) -> some View {
        VStack(alignment: .leading) {
            TextField(title, text: text)
            if let firstError = errors.first(where: { viewModel.validationErrors.contains($0) }) {
                Text(firstError.translatedError)
                    .font(.caption)
                    .foregroundStyle(Color.Studio.warning)
                    .transition(.opacity)
            }
        }
    }
    
    @ViewBuilder
    private func datePicker(_ title: String, selection: Binding<Date>, errors: [ServiceValidationError] = []) -> some View {
        VStack(alignment: .leading) {
            DatePicker(title, selection: selection, displayedComponents: [.hourAndMinute])
            if let firstError = errors.first(where: { viewModel.validationErrors.contains($0) }) {
                Text(firstError.translatedError)
                    .font(.caption)
                    .foregroundStyle(Color.Studio.warning)
                    .transition(.opacity)
            }
        }
    }
}

private extension ServiceValidationError {
    var translatedError: String {
        switch self {
        case .emptyName: return tr.emptyName
        case .emptyPrice: return tr.emptyPrice
        case .invalidDuration: return tr.invalidDuration
        }
    }
}

#Preview {
    NewServiceView(viewModel: NewServiceViewModel(service: nil, persistenceService: AppointmentServicePersistenceService()))
}
