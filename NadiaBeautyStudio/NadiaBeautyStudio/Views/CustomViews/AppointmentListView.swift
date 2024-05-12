//
//  AppointmentListView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import SwiftUI

struct AppointmentListView: View {
    let appointment: Appointment

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(appointment.initials())
                .font(.title)
                .frame(width: 50, height: 50, alignment: .center)
                .padding()
                .overlay(Circle().stroke(Color.black, lineWidth: 3))
            VStack(alignment: .leading) {
                Text(appointment.clientName)
                    .font(.title)
                Text("\(appointment.type)")
                    .font(.headline)
                Spacer()
                    .frame(height: 8)
                Text(Appointment.dateFormatter.string(from: appointment.date))
                Spacer()
                    .frame(height: 8)
                if appointment.inResidence {
                    Text("Ir ao domicílio")
                }
            }
        }
    }
}

#Preview {
    AppointmentListView(appointment: Appointment.example)
}
