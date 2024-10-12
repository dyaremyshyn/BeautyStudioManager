//
//  NewAppointmentViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

class NewAppointmentViewModel: ObservableObject {
    @Published var appointment: StudioAppointment?

    @Published var clientName: String!
    @Published var clientPhoneNumber: String!
    @Published var appointmentDate: Date!
    @Published var price: String!
    @Published var type: AppointmentType = .makeup
    @Published var inResidence: Bool!
    
    private let persistenceService: PersistenceLoader
    
    init(appointment: StudioAppointment?, persistenceService: PersistenceLoader) {
        self.appointment = appointment
        self.persistenceService = persistenceService
        clientName = ""
        clientPhoneNumber = ""
        appointmentDate = Date()
        price = ""
        type = .makeup
        inResidence = false
        
        if let item = self.appointment {
            self.clientName = item.name
            self.clientPhoneNumber = item.phoneNumber ?? ""
            self.appointmentDate = item.date
            self.price = item.price.formatted()
            self.type = AppointmentType(rawValue: item.type) ?? .makeup
            self.inResidence = item.inResidence 
        }
    }
    
    func saveAppointment() {
        let appointment = StudioAppointment(
            id: appointment?.id ?? UUID(),
            date: appointmentDate,
            price: Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0,
            type: type.rawValue,
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
}
