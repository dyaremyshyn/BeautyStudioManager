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
            Section(tr.serviceDetails) {
                TextField(tr.serviceName, text: $viewModel.name)
                TextField(tr.servicePrice, text: $viewModel.price)
                    .keyboardType(.numbersAndPunctuation)
                DatePicker(tr.serviceDuration, selection: $viewModel.duration, displayedComponents: [.hourAndMinute])
            }
            Button(action: {
                viewModel.saveService()
            }, label: {
                Text(tr.save)
                    .foregroundColor(.blue)
            })
            .frame(width: 400, height: 30, alignment: .center)
        }
    }
}

#Preview {
    NewServiceView(viewModel: NewServiceViewModel(service: nil, persistenceService: AppointmentServicePersistenceService()))
}
