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
            "Ano"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector (segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var expectedBalanceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Receitas"
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
        label.text = "Despesas"
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
    
    private lazy var addExpensesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar despesa", for: .normal)
        button.addTarget(self, action: #selector (addExpensesButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        return button
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
        title = "Balanço"
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(horizontalStackView)
        view.addSubview(addExpensesButton)
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
                
        horizontalStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        addExpensesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addExpensesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addExpensesButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addExpensesButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
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

extension BalanceViewController {
    
    private func createPieChart(for data: [AppointmentType: Double]) {
        
        guard !data.isEmpty else {
            pieChartView?.removeFromSuperview()
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
}
