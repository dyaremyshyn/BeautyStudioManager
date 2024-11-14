//
//  AppointmentServicePersistenceService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import CoreData

struct AppointmentServicePersistenceService: AppointmentServicePersistenceLoader {
    private static let typeEntity = "ServiceEntity"
    private let context: NSManagedObjectContext

    public init() {
        self.context = CoreDataStack.shared.context
    }
    
    func getServices() -> [Service] {
        var types: [Service] = []
        
        let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
        
        do {
            let result = try context.fetch(request)
            types = result.map { Service.map(type: $0) }
        } catch {
            print(error.localizedDescription)
        }
        
        return types
    }
    
    func save(service: Service) {
        // Check if the type exists

        let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
        request.predicate = NSPredicate(format: "id == %@", service.id as CVarArg)
        
        do {
            let result = try context.fetch(request)
            
            guard let editClient = result.first else {
                print("Type entity not found with id: \(service.id)")
                
                let newEntry = ServiceEntity(context: context)
                newEntry.id = service.id
                newEntry.name = service.type
                newEntry.price = service.price
                newEntry.duration = service.duration
                
                saveData()
                
                return
            }
            
            // Modify the properties of the fetched appointment
            editClient.name = service.type
            editClient.price = service.price
            editClient.duration = service.duration
            
            saveData()
            
            print("Type entity with id \(service.id) edited successfully")
            
        } catch {
            print("Error editing appointment entity: \(error)")
        }
    }
    
    func delete(service: Service) -> Bool {
        let request = NSFetchRequest<ServiceEntity>(entityName: AppointmentServicePersistenceService.typeEntity)
        request.predicate = NSPredicate(format: "id == %@", service.id as CVarArg)
        
        do {
            let result = try context.fetch(request)
            
            guard let entry = result.first else { return false }
            
            context.delete(entry)
            saveData()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func saveData() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
