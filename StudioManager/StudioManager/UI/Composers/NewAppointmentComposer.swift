//
//  NewAppointmentComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 11/10/2024.
//

import Foundation
import SwiftUI

public final class NewAppointmentComposer {
    
    private init() {}
    
    public static func newAppointmentComposedWith(
        appointment: StudioAppointment?,
        appointmentsPersistenceService: AppointmentPersistenceLoader,
        servicePersistenceService: AppointmentServicePersistenceLoader
    ) -> UIHostingController<NewAppointmentView> {
        let viewModel = NewAppointmentViewModel(
            appointment: appointment,
            appointmentsPersistenceService: appointmentsPersistenceService,
            servicesPersistenceService: servicePersistenceService
        )
        let newAppointmentView = NewAppointmentView(viewModel: viewModel)
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: newAppointmentView)
        return hostingController
    }
}
