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
    private(set) var servicesTypes: [String] = []
    @Published private(set) var appointment: StudioAppointment?
    @Published var clientName: String!
    @Published var clientPhoneNumber: String!
    @Published var appointmentDate: Date!
    @Published var price: String!
    @Published var inResidence: Bool!
    @Published var pricePerKm: String!
    @Published var totalDistance: String!
    private var servicePrice: Double = 0
    private var duration: Double = 0
    private var icon: String = StudioTheme.serviceDefaultImage
    @Published var type: String = "Studio" {
        didSet {
            servicePrice = allServices.first(where: { $0.type == type })?.price ?? 0
            price = servicePrice.formatted()
            duration = allServices.first(where: { $0.type == type })?.duration ?? 0
            icon = allServices.first(where: { $0.type == type})?.icon ?? StudioTheme.serviceDefaultImage
        }
    }
    
    private let appointmentsPersistenceService: AppointmentPersistenceLoader
    private let servicesPersistenceService: AppointmentServicePersistenceLoader
    private var subscriptions: [AnyCancellable] = []
    @Published var validationErrors: [AppointmentValidationError] = []
    @Published var showToast: Bool = false

    init(
        appointment: StudioAppointment?,
        appointmentsPersistenceService: AppointmentPersistenceLoader,
        servicesPersistenceService: AppointmentServicePersistenceLoader
    ) {
        self.appointment = appointment
        self.appointmentsPersistenceService = appointmentsPersistenceService
        self.servicesPersistenceService = servicesPersistenceService
        
        bind()
        
        fetchData()
        resetFields()
        setFields(from: appointment)
    }
    
    func fetchData() {
        allServices = servicesPersistenceService.fetchAll()
        servicesTypes = allServices.map { $0.type }.filter { !$0.isEmpty }
        type = servicesTypes.first ?? ""
    }
    
    func saveAppointment() {
        let appointment = StudioAppointment(
            id: self.appointment?.id ?? UUID(),
            date: appointmentDate,
            price: StringConverter.convertStringToDouble(price),
            type: type,
            inResidence: inResidence,
            name: clientName,
            phoneNumber: clientPhoneNumber,
            duration: duration,
            addedToCalendar: false,
            icon: icon
        )
        
        // Save created appointment to core data
        appointmentsPersistenceService.add(appointment: appointment)
        showToast = true

        // Reset fields after saving if needed
        resetFields()
    }
}

private extension NewAppointmentViewModel {
    func resetFields() {
        clientName = ""
        clientPhoneNumber = ""
        appointmentDate = .now
        price = ""
        duration = 0
        type = servicesTypes.first ?? ""
        inResidence = false
        pricePerKm = StringConverter.convertDoubleToString(StudioTheme.pricePerKm)
        totalDistance = ""
    }
    
    func setFields(from appointment: StudioAppointment?) {
        guard let appointment else { return }
        self.clientName = appointment.name
        self.clientPhoneNumber = appointment.phoneNumber ?? ""
        self.appointmentDate = appointment.date
        self.price = StringConverter.convertDoubleToString(appointment.price)
        self.type = appointment.type
        self.inResidence = appointment.inResidence
    }
    
    func bind() {
        self.servicesPersistenceService.appointmentServiceUpdatedPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: appointmentServiceUpdated)
            .store(in: &subscriptions)
        
        Publishers.CombineLatest($clientName, $price)
            .combineLatest($appointmentDate)
            .combineLatest($pricePerKm)
            .combineLatest($totalDistance)
            .sink { [weak self] (arg0, totalDistance) in
                let (((clientName, price), appointmentDate), pricePerKm) = arg0
                let form = AppointmentValidator.Form(
                    name: clientName,
                    price: price,
                    date: appointmentDate,
                    pricePerKm: pricePerKm,
                    totalDistance: totalDistance
                )
                self?.validationErrors = AppointmentValidator.validate(form: form)
            }
            .store(in: &subscriptions)
        
        Publishers.CombineLatest($pricePerKm, $totalDistance)
            .sink { [weak self] pricePerKm, totalDistance in
                guard let self else { return }
                let pricePerKmValue = pricePerKm ?? ""
                let totalDistanceValue = totalDistance ?? ""
                calculateAppointmentTotalCost(pricePerKm: pricePerKmValue, totalDistance: totalDistanceValue)
            }
            .store(in: &subscriptions)
    }
    
    func appointmentServiceUpdated() {
        fetchData()
    }
    
    func calculateAppointmentTotalCost(pricePerKm: String, totalDistance: String) {
        let pricePerKm = StringConverter.convertStringToDouble(pricePerKm)
        let totalDistance = StringConverter.convertStringToDouble(totalDistance)
        let totalCost = pricePerKm * totalDistance + servicePrice
        self.price = StringConverter.convertDoubleToString(totalCost)
    }
}
