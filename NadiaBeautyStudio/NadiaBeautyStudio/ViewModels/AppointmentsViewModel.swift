//
//  MainViewModel.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import Foundation

final class AppointmentsViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []
    @Published var appointmentsForCurrentWeek: [Appointment] = []
    @Published var profit: String = ""
    
    func fetchAppointments() {
        appointments = PersistenceController.shared.getAppointments()
        calculateMonthlyProfit()
        getAppointmentsForCurrentWeek()
#if DEBUG
    //appointments = Appointment.allCustomers
#endif
    }
    
    func calculateMonthlyProfit()  {
        var profit: Double = 0.0
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        let appointmentsInCurrentMonth = appointments.filter { appointment in
            let appointmentDate = appointment.date
            let appointmentMonth = Calendar.current.component(.month, from: appointmentDate)
            return appointmentMonth == currentMonth
        }
        
        appointmentsInCurrentMonth.forEach { profit += $0.price }
        
        appointments.removeAll { $0.date <= Date() }
        
        self.profit = "\(profit.formatted()) €"
    }
    
    func deleteAppointment(appointment: Appointment) {
        let result = PersistenceController.shared.deleteAppointment(appointment: appointment)
        print("Deleted with success: \(result)")
    }
    
    func getAppointmentsForCurrentWeek() {
        let calendar = Calendar.current
        let now = Date()
        
        // Get the start and end dates of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)),
              let endOfWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek) else {
            print("Failed to calculate start and end dates of the current week.")
            return
        }
        
        // Filter appointments for the current week
        appointmentsForCurrentWeek = appointments.filter { appointment in
            return startOfWeek...endOfWeek ~= appointment.date
        }
        
        appointmentsForCurrentWeek.forEach { appointment in
            appointments.removeAll { $0.id == appointment.id }
        }
    }
}
