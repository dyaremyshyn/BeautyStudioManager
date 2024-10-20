//
//  AppointmentsPersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//


public protocol AppointmentsPersistenceLoader {
    func getStudioAppointments() -> [StudioAppointment]
    func saveStudioAppointment(appointment: StudioAppointment)
    func deleteStudioAppointment(appointment: StudioAppointment) -> Bool
}
