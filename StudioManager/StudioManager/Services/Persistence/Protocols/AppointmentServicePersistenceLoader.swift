//
//  AppointmentTypePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

public protocol AppointmentServicePersistenceLoader {
    func getServices() -> [Service]
    func save(service: Service)
    func delete(service: Service) -> Bool
}
