//
//  NewAppointmentViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

class NewAppointmentViewModel: ObservableObject {
    @Published var appointment: Appointment?

    @Published var clientName = ""
    @Published var clientNumber = ""
    @Published var appointmentDate = Date()
    @Published var price: String = ""
    @Published var type: AppointmentType = .makeup
    @Published var inResidence: Bool = false
    
    init(appointment: Appointment?) {
        self.appointment = appointment
        clientName = ""
        clientNumber = ""
        appointmentDate = Date()
        price = ""
        type = .makeup
        inResidence = false
        
        if let item = self.appointment {
            self.clientName = item.clientName
            self.clientNumber = item.clientNumber ?? ""
            self.appointmentDate = item.date
            self.price = item.price.formatted()
            self.type = AppointmentType(rawValue: item.type) ?? .makeup
            self.inResidence = item.inResidence 
        }
    }
    
    func saveAppointment() {
        let appointment = Appointment(
            id: UUID(),
            clientName: clientName,
            date: appointmentDate,
            price: Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0,
            type: type.rawValue,
            inResidence: inResidence,
            clientNumber: clientNumber
        )
        PersistenceController.shared.saveAppointment(appointment: appointment)
        
        // Reset fields after saving if needed
        clientName = ""
        clientNumber = ""
        appointmentDate = Date()
        price = ""
        type = .makeup
        inResidence = false
    }
}
