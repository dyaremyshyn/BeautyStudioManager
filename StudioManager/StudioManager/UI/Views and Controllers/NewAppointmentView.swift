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
        Form {
            Section {
                TextField("Nome da Cliente", text: $viewModel.clientName)
                TextField("Telemóvel da Cliente", text: $viewModel.clientPhoneNumber)
                    .keyboardType(.numberPad)
            } header: {
                Text("Detalhes da Cliente")
            }
            Section {
                DatePicker("Data da marcação", selection: $viewModel.appointmentDate, displayedComponents: [.date, .hourAndMinute])
                
                TextField("Preço", text: $viewModel.price)
                    .keyboardType(.numbersAndPunctuation)
                
                Picker("Tipo de Marcação", selection: $viewModel.type) {
                    ForEach(viewModel.servicesTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(.menu)
                Toggle(isOn: $viewModel.inResidence) {
                    Text("Ir ao domicílio?")
                }
                .toggleStyle(.checkmark)
            } header: {
                Text("Detalhes da Marcação")
            }
            Button(action: {
                viewModel.saveAppointment()
            }, label: {
                Text("Guardar")
                    .foregroundColor(.blue)
            })
            .frame(width: 400, height: 30, alignment: .center)
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct NewAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        NewAppointmentView(
            viewModel: NewAppointmentViewModel(
                appointment: Appointment.example,
                appointmentsPersistenceService: AppointmentPersistenceService(),
                servicesPersistenceService: AppointmentServicePersistenceService()
            )
        )
    }
}
