//
//  Persistence.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import CoreData

protocol Cache {
    func getAppointments() -> [Appointment]
    func saveAppointment(appointment: Appointment)
}

struct PersistenceController: Cache {
    private static let modelName = "NadiaBeautyStudio"
    private static let entity = "AppointmentEntity"

    let container: NSPersistentContainer
    static let shared = PersistenceController()

    private init() {
        container = NSPersistentContainer(name: PersistenceController.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getAppointments() -> [Appointment] {
        var appointments: [Appointment] = []
        
        let request = NSFetchRequest<AppointmentEntity>(entityName: PersistenceController.entity)
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            appointments =  result.map { Appointment.map(appointment: $0 ) }
            appointments.sort(by: { $0.date < $1.date })
        } catch {
            print(error.localizedDescription)
        }
        
        return appointments
    }
    
    func saveAppointment(appointment: Appointment) {
        // Check if the appointment exists

        let request = NSFetchRequest<AppointmentEntity>(entityName: PersistenceController.entity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            
            guard let editAppointment = result.first else {
                print("Appointment entity not found with id: \(appointment.id)")
                
                let newEntry = AppointmentEntity(context: container.viewContext)
                newEntry.id = appointment.id
                newEntry.clientName = appointment.clientName
                newEntry.date = appointment.date
                newEntry.inResidence = appointment.inResidence
                newEntry.price = appointment.price
                newEntry.type = appointment.type
                newEntry.clientNumber = appointment.clientNumber
                
                self.saveData()
                
                return
            }
            
            // Modify the properties of the fetched appointment
            editAppointment.clientName = appointment.clientName
            editAppointment.date = appointment.date
            editAppointment.inResidence = appointment.inResidence
            editAppointment.price = appointment.price
            editAppointment.type = appointment.type
            editAppointment.clientNumber = appointment.clientNumber
            
            self.saveData()
            
            print("Appointment entity with id \(appointment.id) edited successfully")
            
        } catch {
            print("Error editing appointment entity: \(error)")
        }
    }
    
    func deleteAppointment(appointment: Appointment) -> Bool {
        let request = NSFetchRequest<AppointmentEntity>(entityName: PersistenceController.entity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            
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
