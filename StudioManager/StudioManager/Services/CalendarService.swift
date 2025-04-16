//
//  CalendarService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 15/11/2024.
//

import Foundation
import EventKit
import UIKit

struct CalendarService {
    
    static func createEvent(to appointment: StudioAppointment, completion: @escaping (String?) -> Void) {
        let eventStore = EKEventStore()

        eventStore.requestFullAccessToEvents { granted, error in
            guard granted, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let event = EKEvent(eventStore: eventStore)
            event.title = "\(appointment.name) – \(appointment.type)"
            event.startDate = appointment.date
            event.endDate = appointment.endDate
            event.notes = String(
                format: "%@ %.2f€\n%@",
                tr.calendarAppointmentPrice,
                appointment.price,
                appointment.inResidence ? tr.calendarInResidence : ""
            )
            event.alarms = [EKAlarm(relativeOffset: -86400), EKAlarm(relativeOffset: -7200)]
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
                let eventID = event.eventIdentifier
                DispatchQueue.main.async {
                    completion(eventID)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    static func updateEvent(to appointment: StudioAppointment) {
        guard let eventId = appointment.calendarEventId else { return }

        let eventStore = EKEventStore()
        
        eventStore.requestFullAccessToEvents { granted, error in
            guard granted, error == nil else { return }
            
            guard let event = eventStore.event(withIdentifier: eventId) else { return }
            
            event.title = appointment.name + " - " +  appointment.type
            event.startDate = appointment.date
            event.endDate = appointment.endDate
            event.notes = String(format: "%@ %2.f €\n%@", tr.calendarAppointmentPrice, appointment.price, (appointment.inResidence ? tr.calendarInResidence : ""))
            event.alarms = [EKAlarm(relativeOffset: -86400), EKAlarm(relativeOffset: -7200)]
            event.calendar = eventStore.defaultCalendarForNewEvents

            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
            } catch {
                print("Error updating event: \(error.localizedDescription)")
            }
        }
    }
    
    static func deleteEvent(eventId: String?) {
        guard let eventId else { return }
        let eventStore = EKEventStore()
        
        eventStore.requestFullAccessToEvents { granted, error in
            guard granted, error == nil else { return }
            
            guard let event = eventStore.event(withIdentifier: eventId) else { return }
            
            do {
                try eventStore.remove(event, span: .thisEvent, commit: true)
            } catch {
                print("Erro ao eliminar evento: \(error.localizedDescription)")
            }
        }
    }
}
