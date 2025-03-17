//
//  NewServiceComposer.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/11/2024.
//

import Foundation
import SwiftUI

public final class NewServiceComposer {
    
    private init() {}
    
    public static func newServiceComposedWith(
        service: Service?,
        persistenceLoader: AppointmentServicePersistenceLoader
    ) -> UIHostingController<NewServiceView> {
        let viewModel = NewServiceViewModel(service: service, persistenceService: persistenceLoader)
        let newServiceView = NewServiceView(viewModel: viewModel)
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: newServiceView)
        return hostingController
    }
}
