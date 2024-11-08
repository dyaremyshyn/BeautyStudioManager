//
//  PricingTableViewController.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import UIKit
import Combine

public class PricingTableViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var viewModel: PricingTableViewModel? {
        didSet { bind() }
    }
    private var dataSource: UITableViewDiffableDataSource<StudioSection, AppointmentTypeModel>?
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppointmentTypeViewCell.self, forCellReuseIdentifier: AppointmentTypeViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData()
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<StudioSection, AppointmentTypeModel>(tableView: tableView, cellProvider: { tableView, indexPath, model in
                let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTypeViewCell.reuseIdentifier, for: indexPath) as! AppointmentTypeViewCell
                cell.configure(model: model)
                return cell
            }
        )
        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }

    private func setupView() {
        title = "Tabela de Preços"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind() {
        viewModel?.$pricingTableList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] prices in
                guard let self else { return }
                self.applySnapshot(prices: prices)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(prices: [AppointmentTypeModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<StudioSection, AppointmentTypeModel>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(prices, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Add new Appointment Type
extension PricingTableViewController {
    
    @objc func addTapped() {
        print("Add new price")
    }
}
