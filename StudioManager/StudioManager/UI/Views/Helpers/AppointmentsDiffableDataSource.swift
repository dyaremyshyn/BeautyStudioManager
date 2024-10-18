//
//  AppointmentsDiffableDataSource.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import UIKit

class AppointmentsDiffableDataSource: UITableViewDiffableDataSource<StudioSection, StudioAppointment> {
    // Reference to the view model
    weak var viewModel: AppointmentsListViewModel?
    
    // Custom initializer that accepts the view model
    init(tableView: UITableView, viewModel: AppointmentsListViewModel?, cellProvider: @escaping UITableViewDiffableDataSource<StudioSection, StudioAppointment>.CellProvider) {
        self.viewModel = viewModel
        super.init(tableView: tableView, cellProvider: cellProvider)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appointmentToDelete = itemIdentifier(for: indexPath) else { return }
            // Remove the item from your data model in ViewModel
            viewModel?.removeAppointment(index: indexPath.row)
            // Apply updated snapshot
            var snapshot = snapshot()
            snapshot.deleteItems([appointmentToDelete])
            apply(snapshot, animatingDifferences: true)
        }
    }
}
