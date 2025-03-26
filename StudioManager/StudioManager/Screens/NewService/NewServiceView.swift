//
//  NewServiceView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/11/2024.
//

import SwiftUI

public struct NewServiceView: View {
    @StateObject var viewModel: NewServiceViewModel

    public var body: some View {
        ZStack(alignment: .bottom){
            Form {
                Section(tr.serviceDetails) {
                    HStack{
                        ServiceImage(icon: viewModel.icon)
                            .onTapGesture {
                                viewModel.showIconPicker = true
                            }
                        textField(tr.serviceName, text: $viewModel.name, errors: [.emptyName])
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
        .sheet(isPresented: $viewModel.showIconPicker) {
            IconPickerView(viewModel: $viewModel.pickerViewModel, selectedIcon: $viewModel.icon)
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
            StudioDatePicker(title: title, selection: selection, minuteInterval: 10, mode: .time)
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
