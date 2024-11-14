//
//  Persistence.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import CoreData

struct AppointmentPersistenceService: AppointmentPersistenceLoader {
    private static let studioEntity = "StudioEntity"
    private let context: NSManagedObjectContext

    public init() {
        self.context = CoreDataStack.shared.context
    }
    
    func getStudioAppointments() -> [StudioAppointment] {
        var appointments: [StudioAppointment] = []
        
        let request = NSFetchRequest<StudioEntity>(entityName: AppointmentPersistenceService.studioEntity)
        
        do {
            let result = try context.fetch(request)
            appointments = result.map { StudioAppointment.map(appointment: $0) }
            appointments.sort(by: { $0.date < $1.date })
        } catch {
            print(error.localizedDescription)
        }
        
        return appointments
    }
    
    func saveStudioAppointment(appointment: StudioAppointment) {
        // Check if the appointment exists

        let request = NSFetchRequest<StudioEntity>(entityName: AppointmentPersistenceService.studioEntity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
        do {
            let result = try context.fetch(request)
            
            guard let editClient = result.first else {
                print("Client entity not found with id: \(appointment.id)")
                
                let newEntry = StudioEntity(context: context)
                newEntry.id = appointment.id
                newEntry.name = appointment.name
                newEntry.phoneNumber = appointment.phoneNumber
                newEntry.date = appointment.date
                newEntry.inResidence = appointment.inResidence
                newEntry.price = appointment.price
                newEntry.type = appointment.type
                
                saveData()
                
                return
            }
            
            // Modify the properties of the fetched appointment
            editClient.name = appointment.name
            editClient.phoneNumber = appointment.phoneNumber
            editClient.date = appointment.date
            editClient.price = appointment.price
            editClient.type = appointment.type
            editClient.inResidence = appointment.inResidence
            
            saveData()
            
            print("Client entity with id \(appointment.id) edited successfully")
            
        } catch {
            print("Error editing appointment entity: \(error)")
        }
    }
    
    func deleteStudioAppointment(appointment: StudioAppointment) -> Bool {
        let request = NSFetchRequest<StudioEntity>(entityName: AppointmentPersistenceService.studioEntity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
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
