//
//  AppointmentTypePersistenceLoader.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

public protocol AppointmentTypePersistenceLoader {
    func getAppointmentTypes() -> [AppointmentTypeModel]
    func saveAppointmentType(type: AppointmentTypeModel)
    func deleteAppointmentType(type: AppointmentTypeModel) -> Bool
}
