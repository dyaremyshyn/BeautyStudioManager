//
//  NewAppointmentView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import SwiftUI

struct NewAppointmentView: View {
    @StateObject private var viewModel: NewAppointmentViewModel

    init(appointment: Appointment?) {
        _viewModel = StateObject(wrappedValue: NewAppointmentViewModel(appointment: appointment))
    }
    
    var body: some View {
            NavigationView {
                Form {
                    Section {
                        TextField("Nome da Cliente", text: $viewModel.clientName)
                        TextField("Número da Cliente", text: $viewModel.clientNumber)
                            .keyboardType(.numberPad)
                    } header: {
                        Text("Detalhes da Cliente")
                    }
                    Section {
                        DatePicker("Data da marcação", selection: $viewModel.appointmentDate, displayedComponents: [.date, .hourAndMinute])
                        
                        TextField("Preço", text: $viewModel.price)
                            .keyboardType(.numbersAndPunctuation)
                        
                        Picker("Tipo de Marcação", selection: $viewModel.type) {
                            ForEach(AppointmentType.allCases, id: \.self) { type in
                                Text(type.rawValue)
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
                            .foregroundColor(.primary)
                    })
                    .frame(width: 400, height: 30, alignment: .center)
                }
                .navigationBarTitle(viewModel.appointment == nil ? "Nova Marcação" : "Editar Marcação")
            }
        }
}

struct NewAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        NewAppointmentView(appointment: Appointment.example)
    }
}
