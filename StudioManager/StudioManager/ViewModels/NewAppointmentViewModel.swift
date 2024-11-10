//
//  NewAppointmentViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

class NewAppointmentViewModel: ObservableObject {
    @Published private(set) var appointment: StudioAppointment?

    @Published var clientName: String!
    @Published var clientPhoneNumber: String!
    @Published var appointmentDate: Date!
    @Published var price: String!
    @Published var type: AppointmentType = .makeup
    @Published var inResidence: Bool!
    
    private let persistenceService: AppointmentPersistenceLoader
    
    init(appointment: StudioAppointment?, persistenceService: AppointmentPersistenceLoader) {
        self.appointment = appointment
        self.persistenceService = persistenceService
        resetFields()
        setFields(from: appointment)
    }
    
    func saveAppointment() {
        let appointment = StudioAppointment(
            id: appointment?.id ?? UUID(),
            date: appointmentDate,
            price: Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0,
            type: type,
            inResidence: inResidence,
            name: clientName,
            phoneNumber: clientPhoneNumber
        )
        
        // Save created appointment to core data
        persistenceService.saveStudioAppointment(appointment: appointment)
        
        // Reset fields after saving if needed
        resetFields()
    }
    
    private func resetFields() {
        self.appointment = nil
        clientName = ""
        clientPhoneNumber = ""
        appointmentDate = Date()
        price = ""
        type = .makeup
        inResidence = false
    }
    
    private func setFields(from appointment: StudioAppointment?) {
        guard let appointment else { return }
        self.clientName = appointment.name
        self.clientPhoneNumber = appointment.phoneNumber ?? ""
        self.appointmentDate = appointment.date
        self.price = appointment.price.formatted()
        self.type = AppointmentType(rawValue: appointment.type.rawValue) ?? .makeup
        self.inResidence = appointment.inResidence
    }
}
