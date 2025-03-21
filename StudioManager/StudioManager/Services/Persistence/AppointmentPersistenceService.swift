//
//  Persistence.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import CoreData

class AppointmentPersistenceService: AppointmentPersistenceLoader {
    private static let studioEntity = "StudioEntity"
    private let context: NSManagedObjectContext

    public init() {
        self.context = CoreDataStack.shared.context
    }
    
    func fetchAll() -> [StudioAppointment] {
        var appointments: [StudioAppointment] = []
        context.performAndWait {
            let request = NSFetchRequest<StudioEntity>(entityName: AppointmentPersistenceService.studioEntity)
            do {
                let result = try context.fetch(request)
                appointments = result.map { StudioAppointment.map(appointment: $0) }
                appointments.sort(by: { $0.date < $1.date })
            } catch {
                print("Error fetching appointments: \(error.localizedDescription)")
            }
        }
        return appointments
    }
    
    func add(appointment: StudioAppointment) {
        context.performAndWait {
            if let existingEntity = fetchStudioEntity(for: appointment) {
                existingEntity.name = appointment.name
                existingEntity.phoneNumber = appointment.phoneNumber
                existingEntity.date = appointment.date
                existingEntity.price = appointment.price
                existingEntity.type = appointment.type
                existingEntity.inResidence = appointment.inResidence
                existingEntity.addedToCalendar = appointment.addedToCalendar
                existingEntity.duration = appointment.duration
            } else {
                let newEntry = StudioEntity(context: context)
                newEntry.id = appointment.id
                newEntry.name = appointment.name
                newEntry.phoneNumber = appointment.phoneNumber
                newEntry.date = appointment.date
                newEntry.inResidence = appointment.inResidence
                newEntry.price = appointment.price
                newEntry.type = appointment.type
                newEntry.addedToCalendar = appointment.addedToCalendar
                newEntry.duration = appointment.duration
            }
            
            do {
                try context.save()
            } catch {
                print("Error saving appointment: \(error.localizedDescription)")
            }
        }
    }
    
    func delete(appointment: StudioAppointment) -> Bool {
        var success = false
        context.performAndWait {
            if let entityToDelete = fetchStudioEntity(for: appointment) {
                context.delete(entityToDelete)
                do {
                    try context.save()
                    success = true
                } catch {
                    print("Error deleting appointment: \(error.localizedDescription)")
                    success = false
                }
            } else {
                success = false
            }
        }
        return success
    }
}

private extension AppointmentPersistenceService {
    private func fetchStudioEntity(for appointment: StudioAppointment) -> StudioEntity? {
        let request = NSFetchRequest<StudioEntity>(entityName: AppointmentPersistenceService.studioEntity)
        request.predicate = NSPredicate(format: "id == %@", appointment.id as CVarArg)
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Error fetching StudioEntity: \(error.localizedDescription)")
            return nil
        }
    }
}
