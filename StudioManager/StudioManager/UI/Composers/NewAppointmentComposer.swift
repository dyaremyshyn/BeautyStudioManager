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
        persistenceLoader: AppointmentPersistenceLoader
    ) -> UIHostingController<NewAppointmentView> {
        let viewModel = NewAppointmentViewModel(appointment: appointment, persistenceService: persistenceLoader)
        let newAppointmentView = NewAppointmentView(viewModel: viewModel)
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: newAppointmentView)
        return hostingController
    }
}
