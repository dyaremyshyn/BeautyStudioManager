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
            EmptyView(imageName: "text.page.slash") {
                Text("Não há nenhum serviço introduzido! \nAdicione um serviço para começar a introduzir as marcações")
            }
        } else {
            Form {
                Section("Detalhes da Cliente") {
                    TextField("Nome da Cliente", text: $viewModel.clientName)
                    TextField("Telemóvel da Cliente", text: $viewModel.clientPhoneNumber)
                        .keyboardType(.numberPad)
                }
                Section("Detalhes da Marcação") {
                    DatePicker("Data da marcação", selection: $viewModel.appointmentDate, displayedComponents: [.date, .hourAndMinute])
                    
                    TextField("Preço", text: $viewModel.price)
                        .keyboardType(.numbersAndPunctuation)
                    
                    Picker("Tipo de Marcação", selection: $viewModel.type) {
                        ForEach(viewModel.servicesTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.menu)
                    HStack {
                        CheckView(isChecked: $viewModel.inResidence)
                        Text("Ir ao domicílio?")
                            .font(.body)
                    }
                }
                Button(action: viewModel.saveAppointment) {
                    Text("Guardar")
                        .foregroundColor(.blue)
                }
                .frame(width: 400, height: 30, alignment: .center)
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
