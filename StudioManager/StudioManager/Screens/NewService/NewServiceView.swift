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
                    TextField(tr.serviceName, text: $viewModel.name)
                    TextField(tr.servicePrice, text: $viewModel.price)
                        .keyboardType(.numbersAndPunctuation)
                    DatePicker(tr.serviceDuration, selection: $viewModel.duration, displayedComponents: [.hourAndMinute])
                }
            }
            StudioButton(title: tr.save, action: viewModel.saveService)
                .padding(.horizontal)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    NewServiceView(viewModel: NewServiceViewModel(service: nil, persistenceService: AppointmentServicePersistenceService()))
}
