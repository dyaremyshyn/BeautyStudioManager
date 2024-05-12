//
//  AppointmentsView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 12/05/2024.
//

import SwiftUI

struct AppointmentsView: View {
    @StateObject var viewModel = AppointmentsViewModel()
    
    var body: some View {
        List {
            Section("Ganho mensal") {
                Text(viewModel.calculateMonthlyProfit())
            }
            ForEach(viewModel.appointments) { item in
                AppointmentListView(appointment: item)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Marcações")
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: NewAppointmentView()) {
                    Label("Nova Marcação", systemImage: "plus")
                }
            }
        }
        .onAppear {
            viewModel.fetchAppointments()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let appointment = offsets.map({ viewModel.appointments[$0] }).first else { return }
            viewModel.deleteAppointment(appointment: appointment)
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View{
        AppointmentsView()
    }
}
