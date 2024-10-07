//
//  Persist.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//


protocol Persist {
    func getAppointments() -> [Appointment]
    func saveAppointments(to client: Client)
}
