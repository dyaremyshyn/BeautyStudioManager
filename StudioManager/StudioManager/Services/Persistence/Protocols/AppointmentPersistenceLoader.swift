//
//  AppointmentPersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//


public protocol AppointmentPersistenceLoader {
    func fetchAll() -> [StudioAppointment]
    func add(appointment: StudioAppointment)
    func delete(appointment: StudioAppointment) -> Bool
}
