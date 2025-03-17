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
        Form {
            Section {
                TextField("Nome", text: $viewModel.name)
                TextField("Valor", text: $viewModel.price)
                    .keyboardType(.numbersAndPunctuation)
                DatePicker("Duração", selection: $viewModel.duration, displayedComponents: [.hourAndMinute])
            } header: {
                Text("Detalhes do Serviço")
            }
            Button(action: {
                viewModel.saveService()
            }, label: {
                Text("Guardar")
                    .foregroundColor(.blue)
            })
            .frame(width: 400, height: 30, alignment: .center)
        }
    }
}

#Preview {
    NewServiceView(viewModel: NewServiceViewModel(service: nil, persistenceService: AppointmentServicePersistenceService()))
}
