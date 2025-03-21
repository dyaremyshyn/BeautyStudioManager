//
//  NewServiceViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 10/11/2024.
//

import Foundation
import Combine

class NewServiceViewModel: ObservableObject {
    @Published var name: String!
    @Published var price: String!
    @Published var duration: Date!
    @Published var icon: String = StudioTheme.serviceDefaultImage
    @Published var validationErrors: [ServiceValidationError] = []
    @Published var showToast: Bool = false
    @Published var showIconPicker: Bool = false
    @Published var pickerViewModel = IconPickerViewModel()

    private var subscriptions: [AnyCancellable] = []
    
    @Published private(set) var service: Service?
    private let persistenceService: AppointmentServicePersistenceLoader
    
    init(service: Service?, persistenceService: AppointmentServicePersistenceLoader) {
        self.service = service
        self.persistenceService = persistenceService
        
        Publishers.CombineLatest3($name, $price, $duration)
            .sink { [weak self] name, price, duration in
                self?.validationErrors = ServiceValidator.validate(name: name, price: price, duration: duration)
            }
            .store(in: &subscriptions)
        
        $name
            .sink { [weak self] name in
                self?.updateIconBasedOnName(name)
            }
            .store(in: &subscriptions)
        
        resetAllFields()
        setFields(from: service)
    }
    
    func saveService() {
        let service = Service(
            id: UUID(),
            type: name,
            price: StringConverter.convertStringToDouble(price),
            duration: DurationConverter.convertDurationToTimeInterval(duration)
        )
        
        // Save created service to core data
        persistenceService.add(service: service)
        showToast = true
        
        // Reset all fields
        resetAllFields()
    }
}

private extension NewServiceViewModel {
    func resetAllFields() {
        name = ""
        price = ""
        duration = Date(timeIntervalSince1970: 3600) // 1h in seconds
    }
    
    func setFields(from service: Service?) {
        guard let service else { return }
        name = service.type
        price = StringConverter.convertDoubleToString(service.price)
        duration = DurationConverter.convertDurationToDate(service.duration)
    }
    
    func updateIconBasedOnName(_ name: String?) {
        guard let name else {
            self.icon = StudioTheme.serviceDefaultImage
            return
        }
        
        pickerViewModel.searchText = name
        if let matchedIcon = pickerViewModel.iconFilter.first {
            icon = matchedIcon
            if !pickerViewModel.inputIcons.contains(matchedIcon) {
                pickerViewModel.inputIcons.append(matchedIcon)
            }
        } else {
            icon = StudioTheme.serviceDefaultImage
        }
    }
}
