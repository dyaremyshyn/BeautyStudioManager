//
//  NewAppointmentComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 11/10/2024.
//

import Foundation
import SwiftUI

final class NewAppointmentComposer {
    
    private init() {}
    
    static func newAppointmentComposedWith(
        appointment: StudioAppointment?,
        appointmentsPersistenceService: AppointmentPersistenceLoader,
        servicePersistenceService: AppointmentServicePersistenceLoader,
        coordinator: NewAppointmentCoordinator
    ) -> UIHostingController<NewAppointmentView> {
        let viewModel = NewAppointmentViewModel(
            appointment: appointment,
            appointmentsPersistenceService: appointmentsPersistenceService,
            servicesPersistenceService: servicePersistenceService,
            coordinator: coordinator
        )
        let newAppointmentView = NewAppointmentView(viewModel: viewModel) 
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: newAppointmentView)
        return hostingController
    }
}
