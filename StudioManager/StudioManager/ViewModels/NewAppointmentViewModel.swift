//
//  NewAppointmentViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation
import Combine

class NewAppointmentViewModel: ObservableObject {
    private var allServices: [Service] = []
    public private(set) var servicesTypes: [String] = []
    @Published private(set) var appointment: StudioAppointment?{
        didSet { setFields(from: appointment) }
    }
    @Published var clientName: String!
    @Published var clientPhoneNumber: String!
    @Published var appointmentDate: Date!
    @Published var price: String!
    @Published var inResidence: Bool!
    private var duration: Double = 0
    @Published var type: String = "Maquilhagem" {
        didSet {
            price = allServices.first(where: { $0.type == type })?.price.formatted() ?? ""
            duration = allServices.first(where: { $0.type == type })?.duration ?? 0
        }
    }
    
    private let appointmentsPersistenceService: AppointmentPersistenceLoader
    private let servicesPersistenceService: AppointmentServicePersistenceLoader
    private var subscriptions: [AnyCancellable] = []
    
    init(
        appointment: StudioAppointment?,
        appointmentsPersistenceService: AppointmentPersistenceLoader,
        servicesPersistenceService: AppointmentServicePersistenceLoader
    ) {
        self.appointment = appointment
        self.appointmentsPersistenceService = appointmentsPersistenceService
        self.servicesPersistenceService = servicesPersistenceService
        
        self.servicesPersistenceService.appointmentServiceUpdatedPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: appointmentServiceUpdated)
            .store(in: &subscriptions)
        
        fetchData()
        resetFields()
    }
    
    public func fetchData() {
        allServices = servicesPersistenceService.fetchAll()
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
            phoneNumber: clientPhoneNumber,
            duration: duration,
            addedToCalendar: false
        )
        
        // Save created appointment to core data
        appointmentsPersistenceService.add(appointment: appointment)
        
        // Reset fields after saving if needed
        resetFields()
    }
}

private extension NewAppointmentViewModel {
    func resetFields() {
        self.appointment = nil
        clientName = ""
        clientPhoneNumber = ""
        appointmentDate = Date()
        price = ""
        duration = 0
        type = servicesTypes.first ?? ""
        inResidence = false
    }
    
    func setFields(from appointment: StudioAppointment?) {
        guard let appointment else { return }
        self.clientName = appointment.name
        self.clientPhoneNumber = appointment.phoneNumber ?? ""
        self.appointmentDate = appointment.date
        self.price = appointment.price.formatted()
        self.type = appointment.type
        self.inResidence = appointment.inResidence
    }
    
    func appointmentServiceUpdated() {
        fetchData()
    }
}
