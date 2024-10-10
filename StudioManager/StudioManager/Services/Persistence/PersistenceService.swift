//
//  Persistence.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import CoreData

struct PersistenceService: PersistenceLoader {
    private static let modelName = "StudioManager"
    private static let appointmentEntity = "AppointmentEntity"
    private static let clientEntity = "ClientEntity"
    private static let studioEntity = "StudioEntity"

    let container: NSPersistentContainer

    public init() {
        container = NSPersistentContainer(name: PersistenceService.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getAppointments() -> [Appointment] {
        var appointments: [Appointment] = []
        
        let request = NSFetchRequest<ClientEntity>(entityName: PersistenceService.clientEntity)
        
        do {
            let result = try container.viewContext.fetch(request)
            let clients = result.map { Client.map(client: $0) }
            
            clients.forEach {
                appointments += $0.appointments
            }
            appointments.sort(by: { $0.date < $1.date })
        } catch {
            print(error.localizedDescription)
        }
        
        return appointments
    }
    
    func getStudioAppointments() -> [StudioAppointment] {
        var appointments: [StudioAppointment] = []
        
        let request = NSFetchRequest<StudioEntity>(entityName: PersistenceService.studioEntity)
        
        do {
            let result = try container.viewContext.fetch(request)
            let clients = result.map { StudioAppointment.map(appointment: $0) }
        
            appointments.sort(by: { $0.date < $1.date })
        } catch {
            print(error.localizedDescription)
        }
        
        return appointments
    }
    
    func saveStudioAppointment(appointment: StudioAppointment) {
        // Check if the appointment exists

        let request = NSFetchRequest<StudioEntity>(entityName: PersistenceService.studioEntity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            guard let editClient = result.first else {
                print("Client entity not found with id: \(appointment.id)")
                
                let newEntry = StudioEntity(context: container.viewContext)
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
    
    func saveAppointments(to client: Client) {
        // Check if the appointment exists

        let request = NSFetchRequest<ClientEntity>(entityName: PersistenceService.clientEntity)
        request.predicate = NSPredicate(format: "id == %@", client.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            guard let editClient = result.first else {
                print("Client entity not found with id: \(client.id)")
                
                let newEntry = ClientEntity(context: container.viewContext)
                newEntry.id = client.id
                newEntry.name = client.name
                newEntry.phoneNumber = client.phoneNumber
                newEntry.appointments = NSSet(array: client.appointments)
                
                self.saveData()
                
                return
            }
            
            // Modify the properties of the fetched appointment
            editClient.name = client.name
            editClient.phoneNumber = client.phoneNumber
            editClient.appointments = NSSet(array: client.appointments)
            
            self.saveData()
            
            print("Client entity with id \(client.id) edited successfully")
            
        } catch {
            print("Error editing appointment entity: \(error)")
        }
    }
    
    func deleteAppointment(appointment: Appointment) -> Bool {
        let request = NSFetchRequest<AppointmentEntity>(entityName: PersistenceService.appointmentEntity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        
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
