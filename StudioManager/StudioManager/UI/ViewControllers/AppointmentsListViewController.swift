//
//  AppointmentsListViewController.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import UIKit
import Combine

class AppointmentsListViewController: UITableViewController {
    
    private var cancellables = Set<AnyCancellable>()
    var viewModel: AppointmentsListViewModel? {
        didSet { bind() }
    }
    
    // MARK: - UI
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            FilterCalendar.today.rawValue,
            FilterCalendar.week.rawValue,
            FilterCalendar.month.rawValue,
            FilterCalendar.all.rawValue])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
   
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func bind() {
        
    }
}

