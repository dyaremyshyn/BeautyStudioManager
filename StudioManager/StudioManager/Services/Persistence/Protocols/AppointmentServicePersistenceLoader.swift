//
//  AppointmentTypePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import Foundation
import Combine

public protocol AppointmentServicePersistenceLoader {
    var appointmentServiceUpdatedPublisher: AnyPublisher<Void, Never> { get }
    
    func fetchAll() -> [Service]
    func add(service: Service)
    func delete(service: Service) -> Bool
}
