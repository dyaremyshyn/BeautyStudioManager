//
//  AppointmentTypePersistenceService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import CoreData

struct AppointmentTypePersistenceService: AppointmentTypePersistenceLoader {
    private static let modelName = "StudioManager"
    private static let typeEntity = "AppointmentTypeEntity"

    let container: NSPersistentContainer

    public init() {
        container = NSPersistentContainer(name: AppointmentTypePersistenceService.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getAppointmentTypes() -> [AppointmentTypeModel] {
        var types: [AppointmentTypeModel] = []
        
        let request = NSFetchRequest<AppointmentTypeEntity>(entityName: AppointmentTypePersistenceService.typeEntity)
        
        do {
            let result = try container.viewContext.fetch(request)
            types = result.map { AppointmentTypeModel.map(type: $0) }
        } catch {
            print(error.localizedDescription)
        }
        
        return types
    }
    
    func saveAppointmentType(type: AppointmentTypeModel) {
        // Check if the type exists

        let request = NSFetchRequest<AppointmentTypeEntity>(entityName: AppointmentTypePersistenceService.typeEntity)
        request.predicate = NSPredicate(format: "id == %@", type.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            guard let editClient = result.first else {
                print("Type entity not found with id: \(type.id)")
                
                let newEntry = AppointmentTypeEntity(context: container.viewContext)
                newEntry.id = type.id
                newEntry.name = type.appointmentTypeName
                newEntry.price = type.price
                newEntry.duration = Date(timeIntervalSince1970: type.duration)
                
                saveData()
                
                return
            }
            
            // Modify the properties of the fetched appointment
            editClient.name = type.appointmentTypeName
            editClient.price = type.price
            editClient.duration = Date(timeIntervalSince1970: type.duration)
            
            saveData()
            
            print("Type entity with id \(type.id) edited successfully")
            
        } catch {
            print("Error editing appointment entity: \(error)")
        }
    }
    
    func deleteAppointmentType(type: AppointmentTypeModel) -> Bool {
        let request = NSFetchRequest<AppointmentTypeEntity>(entityName: AppointmentTypePersistenceService.typeEntity)
        request.predicate = NSPredicate(format: "id == %@", type.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            guard let entry = result.first else { return false }
            
            container.viewContext.delete(entry)
            saveData()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
