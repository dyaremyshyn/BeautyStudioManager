//
//  NewAppointmentView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import SwiftUI

public struct NewAppointmentView: View {
    @StateObject var viewModel: NewAppointmentViewModel

    public var body: some View {
        if viewModel.servicesTypes.isEmpty {
            StudioEmptyView(imageName: StudioTheme.emptyImage) {
                Text(tr.appointmentEmptyDescription)
            }
        } else {
            ZStack(alignment: .bottom){
                Form {
                    Section(tr.clientDetails) {
                        textField(tr.clientName, text: $viewModel.clientName, errors: [.emptyClientName])
                        textField(tr.clientPhoneNumber, text: $viewModel.clientPhoneNumber, errors: [])
                            .keyboardType(.numberPad)
                    }
                    Section(tr.appointmentDetails) {
                        datePicker(tr.appointmentDate, selection: $viewModel.appointmentDate, errors: [.invalidDate])
                        
                        textField(tr.appointmentPrice, text: $viewModel.price, errors: [.emptyPrice])
                            .keyboardType(.numbersAndPunctuation)
                        
                        Picker(tr.appointmentType, selection: $viewModel.type) {
                            ForEach(viewModel.servicesTypes, id: \.self) { type in
                                Text(type)
                            }
                        }
                        .pickerStyle(.menu)
                        HStack {
                            CheckView(isChecked: $viewModel.inResidence)
                            Text(tr.appointmentInResidence)
                                .font(.body)
                        }
                    }
                }
                StudioButton(title: tr.save, enabled: viewModel.validationErrors.isEmpty, action: viewModel.saveAppointment)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            .toast(isVisible: $viewModel.showToast, text: tr.appointmentAddedSuccessfully, image: StudioTheme.successImage)
        }
    }
}

private extension NewAppointmentView {
    @ViewBuilder
    private func textField(_ title: String, text: Binding<String>, errors: [AppointmentValidationError] = []) -> some View {
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
    private func datePicker(_ title: String, selection: Binding<Date>, errors: [AppointmentValidationError] = []) -> some View {
        VStack(alignment: .leading) {
            DatePicker(title, selection: selection, displayedComponents: [.date, .hourAndMinute])
            if let firstError = errors.first(where: { viewModel.validationErrors.contains($0) }) {
                Text(firstError.translatedError)
                    .font(.caption)
                    .foregroundStyle(Color.Studio.warning)
                    .transition(.opacity)
            }
        }
    }
}

private extension AppointmentValidationError {
    var translatedError: String {
        switch self {
        case .emptyClientName: return tr.emptyClientName
        case .emptyPrice: return tr.emptyPrice
        case .invalidDate: return tr.invalidDate
        }
    }
}

#Preview {
    NewAppointmentView(
        viewModel: NewAppointmentViewModel(
            appointment: Appointment.example,
            appointmentsPersistenceService: AppointmentPersistenceService(),
            servicesPersistenceService: AppointmentServicePersistenceService()
        )
    )
}
