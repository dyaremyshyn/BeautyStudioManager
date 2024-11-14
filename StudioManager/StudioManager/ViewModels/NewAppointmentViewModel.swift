//
//  NewAppointmentViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

class NewAppointmentViewModel: ObservableObject {
    private var allServices: [Service] = []
    public private(set) var servicesTypes: [String] = []
    @Published private(set) var appointment: StudioAppointment?
    @Published var clientName: String!
    @Published var clientPhoneNumber: String!
    @Published var appointmentDate: Date!
    @Published var price: String!
    @Published var inResidence: Bool!
    @Published var type: String = "Maquilhagem" {
        didSet {
            price = allServices.first(where: { $0.type == type })?.price.formatted() ?? ""
        }
    }
    
    private let appointmentsPersistenceService: AppointmentPersistenceLoader
    private let servicesPersistenceService: AppointmentServicePersistenceLoader
    
    init(
        appointment: StudioAppointment?,
        appointmentsPersistenceService: AppointmentPersistenceLoader,
        servicesPersistenceService: AppointmentServicePersistenceLoader
    ) {
        self.appointment = appointment
        self.appointmentsPersistenceService = appointmentsPersistenceService
        self.servicesPersistenceService = servicesPersistenceService
        fetchData()
        resetFields()
        setFields(from: appointment)
    }
    
    public func fetchData() {
        allServices = servicesPersistenceService.getServices()
        servicesTypes = allServices.map { $0.type }.filter { !$0.isEmpty }
        type = servicesTypes.first ?? ""
    }
    
    public func saveAppointment() {
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
        appointmentsPersistenceService.saveStudioAppointment(appointment: appointment)
        
        // Reset fields after saving if needed
        resetFields()
    }
    
    private func resetFields() {
        self.appointment = nil
        clientName = ""
        clientPhoneNumber = ""
        appointmentDate = Date()
        price = ""
        type = servicesTypes.first ?? ""
        inResidence = false
    }
    
    private func setFields(from appointment: StudioAppointment?) {
        guard let appointment else { return }
        self.clientName = appointment.name
        self.clientPhoneNumber = appointment.phoneNumber ?? ""
        self.appointmentDate = appointment.date
        self.price = appointment.price.formatted()
        self.type = appointment.type 
        self.inResidence = appointment.inResidence
    }
}
