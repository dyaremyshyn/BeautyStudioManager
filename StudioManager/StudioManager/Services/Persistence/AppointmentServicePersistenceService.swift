//
//  AppointmentServicePersistenceService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import CoreData
import Combine

class AppointmentServicePersistenceService: AppointmentServicePersistenceLoader {
    private static let typeEntity = "ServiceEntity"
    private let context: NSManagedObjectContext
    
    var appointmentServiceUpdatedPublisher: AnyPublisher<Void, Never> {
        appointmentServiceUpdatedSubject.eraseToAnyPublisher()
    }
    private let appointmentServiceUpdatedSubject = PassthroughSubject<Void, Never>()
    
    public init() {
        context = CoreDataStack.shared.context
    }
    
    func fetchAll() -> [Service] {
        var services: [Service] = []
        context.performAndWait {
            let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
            do {
                let result = try context.fetch(request)
                services = result.map { Service.map(type: $0) }
            } catch {
                print("Error fetching services: \(error)")
            }
        }
        return services
    }
    
    func getService(for id: UUID) -> Service? {
        var service: Service?
        context.performAndWait {
            let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            do {
                let result = try context.fetch(request)
                if let serviceEntity = result.first {
                    service = Service.map(type: serviceEntity)
                }
            } catch {
                print("Error fetching service: \(error)")
            }
        }
        return service
    }
    
    func add(service: Service) {
        context.performAndWait {
            let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
            request.predicate = NSPredicate(format: "id == %@", service.id as CVarArg)
            do {
                let result = try context.fetch(request)
                if let entity = result.first {
                    entity.name = service.type
                    entity.price = service.price
                    entity.duration = service.duration
                    entity.icon = service.icon
                    entity.color = service.color.archiveColor
                } else {
                    let newEntry = ServiceEntity(context: context)
                    newEntry.id = service.id
                    newEntry.name = service.type
                    newEntry.price = service.price
                    newEntry.duration = service.duration
                    newEntry.icon = service.icon
                    newEntry.color = service.color.archiveColor
                }
                try context.save()
                appointmentServiceUpdatedSubject.send(())
            } catch {
                print("Error saving service: \(error)")
            }
        }
    }
    
    func delete(service: Service) -> Bool {
        var success = false
        context.performAndWait {
            let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
            request.predicate = NSPredicate(format: "id == %@", service.id as CVarArg)
            do {
                let result = try context.fetch(request)
                if let entity = result.first {
                    context.delete(entity)
                    try context.save()
                    appointmentServiceUpdatedSubject.send(())
                    success = true
                } else {
                    success = false
                }
            } catch {
                print("Error deleting service: \(error)")
                success = false
            }
        }
        return success
    }
}
