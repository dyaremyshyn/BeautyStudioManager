//
//  BalanceViewController.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import UIKit
import Combine

public class BalanceViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var viewModel: BalanceViewModel? {
        didSet { bind() }
    }
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            "Hoje",
            "Semana",
            "Mês",
            "Todas"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector (segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var currentBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expectedBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel?.fetchAppointments()
    }
    
    private func setupView() {
        title = "Balanço"
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(currentBalanceLabel)
        view.addSubview(expectedBalanceLabel)
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        currentBalanceLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        currentBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        currentBalanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        
        expectedBalanceLabel.topAnchor.constraint(equalTo: currentBalanceLabel.bottomAnchor, constant: 20).isActive = true
        expectedBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        expectedBalanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func bind() {
        viewModel?.$currentBalance
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] balance in
                self?.currentBalanceLabel.text = "Current: " + balance
            }
            .store(in: &cancellables)
        
        viewModel?.$expectedBalance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance in
                self?.expectedBalanceLabel.text = "Expected: " + balance
            }
            .store(in: &cancellables)
    }
}

// MARK: - Filter calendar
extension BalanceViewController {
    
    @objc private func segmentedControlValueChanged() {
        let filterCalendar = FilterCalendar(rawValue: segmentedControl.selectedSegmentIndex) ?? .today
        viewModel?.filterAppointments(by: filterCalendar)
    }
}
