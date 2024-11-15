//
//  CalendarEventHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 15/11/2024.
//

import Foundation
import EventKit

struct CalendarEventHelper {
    
    public static func createEvent(to appointment: StudioAppointment) {
        let eventStore = EKEventStore()
            
        // Request calendar access
        eventStore.requestWriteOnlyAccessToEvents(completion: { granted, error in
            guard granted else {
                DispatchQueue.main.async {
                   print("Access to calendar denied")
                }
                return
            }
            
            // Create a new event
            let event = EKEvent(eventStore: eventStore)
            event.title = appointment.name + " - " +  appointment.type
            event.startDate = appointment.date
            event.endDate = appointment.date.addingTimeInterval(TimeInterval(floatLiteral: appointment.duration)) //Calendar.current.date(byAdding: .hour, value: 1, to: appointment.date) ?? appointment.date
            event.notes = "Appointment Price: €\(appointment.price)"
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do {
                try eventStore.save(event, span: .thisEvent)
            } catch {
                print("Failed to save event to calendar")
                return
            }
        })
    }
}
