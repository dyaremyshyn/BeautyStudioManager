//
//  Persistence.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import CoreData

protocol Cache {
    func getAppointments() -> [Appointment]
    func saveAppointments(to client: Client)
}

struct PersistenceController: Cache {
    private static let modelName = "StudioManager"
    private static let appointmentEntity = "AppointmentEntity"
    private static let clientEntity = "ClientEntity"

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
        
        let request = NSFetchRequest<ClientEntity>(entityName: PersistenceController.clientEntity)
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
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
    
    func saveAppointments(to client: Client) {
        // Check if the appointment exists

        let request = NSFetchRequest<ClientEntity>(entityName: PersistenceController.clientEntity)
        request.predicate = NSPredicate(format: "id == %@", client.id as CVarArg)
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            
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
        let request = NSFetchRequest<AppointmentEntity>(entityName: PersistenceController.appointmentEntity)
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
