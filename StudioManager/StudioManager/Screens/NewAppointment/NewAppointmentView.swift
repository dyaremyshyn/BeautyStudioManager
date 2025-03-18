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
            StudioEmptyView(imageName: "text.page.slash") {
                Text(tr.appointmentEmptyDescription)
            }
        } else {
            ZStack(alignment: .bottom){
                Form {
                    Section(tr.clientDetails) {
                        TextField(tr.clientName, text: $viewModel.clientName)
                        TextField(tr.clientPhoneNumber, text: $viewModel.clientPhoneNumber)
                            .keyboardType(.numberPad)
                    }
                    Section(tr.appointmentDetails) {
                        DatePicker(tr.appointmentDate, selection: $viewModel.appointmentDate, displayedComponents: [.date, .hourAndMinute])
                        
                        TextField(tr.appointmentPrice, text: $viewModel.price)
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
                StudioButton(title: tr.save, action: viewModel.saveAppointment)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
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
