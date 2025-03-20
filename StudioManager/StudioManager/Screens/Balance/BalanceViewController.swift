//
//  BalanceViewController.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import UIKit
import Combine
import SwiftUI

public class BalanceViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var viewModel: BalanceViewModel? {
        didSet { bind() }
    }
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [tr.filterToday, tr.filterWeek, tr.filterMonth, tr.filterYear])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .Text.button
        segmentedControl.addTarget(self, action: #selector (segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var expectedBalanceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = tr.incomeTitle
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var expectedBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var verticalBalanceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expectedBalanceTitleLabel, expectedBalanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var expenseTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = tr.expensesTitle
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var verticalExpenseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expenseTitleLabel, expenseLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalBalanceStackView, verticalExpenseStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    private lazy var addExpenseButton: UIView = {
        let studioButton = StudioButton(title: tr.addExpense, buttonType: .secondary, action: addExpensesButtonTapped)
        let hostingController = UIHostingController(rootView: studioButton)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController.view
    }()
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.textAlignment = .center
        label.text = tr.noDataDescription
        return label
    }()
    
    private var pieChartView: PieChartView!
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAppointments()
    }
    
    private func setupView() {
        title = tr.balanceTitle
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(horizontalStackView)
        view.addSubview(addExpenseButton)
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
                
        horizontalStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        addExpenseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addExpenseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addExpenseButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addExpenseButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func bind() {
        viewModel?.$expectedBalance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] amount in
                self?.expectedBalanceLabel.text = amount
            }
            .store(in: &cancellables)
        
        viewModel?.$expense
            .receive(on: DispatchQueue.main)
            .sink { [weak self] amount in
                self?.expenseLabel.text = amount
            }
            .store(in: &cancellables)
        
        viewModel?.$pieChartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.createPieChart(for: data)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Filter calendar
extension BalanceViewController {
    
    @objc private func segmentedControlValueChanged() {
        let filterCalendar = FilterCalendar(rawValue: segmentedControl.selectedSegmentIndex) ?? .today
        viewModel?.filterBalance(by: filterCalendar)
    }
    
    @objc private func addExpensesButtonTapped() {
        viewModel?.addExpense()
    }
}

private extension BalanceViewController {
    
    func createPieChart(for data: [String: Double]) {
        noDataLabel.removeFromSuperview()
        
        guard !data.isEmpty else {
            pieChartView?.removeFromSuperview()
            displayEmptyDataView()
            return
        }
                
        if pieChartView != nil {
            pieChartView.removeFromSuperview()
        }
        
        pieChartView = PieChartView(appointmentAmounts: data)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pieChartView)
        pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pieChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pieChartView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pieChartView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func displayEmptyDataView() {
        view.addSubview(noDataLabel)
        noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
