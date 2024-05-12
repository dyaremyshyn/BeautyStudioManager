//
//  MainViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

final class AppointmentsViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []
    
    func fetchAppointments() {
        appointments = PersistenceController.shared.getAppointments()
#if DEBUG
    appointments = Appointment.allCustomers
#endif
    }
    
    func calculateMonthlyProfit() -> String {
        var profit: Double = 0.0
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        let appointmentsInCurrentMonth = appointments.filter { appointment in
            let appointmentDate = Appointment.dateFormatter.date(from: appointment.date)!
            let appointmentMonth = Calendar.current.component(.month, from: appointmentDate)
            return appointmentMonth == currentMonth
        }
        
        appointmentsInCurrentMonth.forEach { profit += $0.price }
        return "\(profit.formatted()) €"
    }
    
    func deleteAppointment(appointment: Appointment) {
        let result = PersistenceController.shared.deleteAppointment(appointment: appointment)
        print("Deleted with success: \(result)")
    }
}
