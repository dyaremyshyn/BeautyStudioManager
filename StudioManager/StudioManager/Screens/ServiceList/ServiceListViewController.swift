//
//  ServiceListViewController.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 06/11/2024.
//

import UIKit
import Combine

public class ServiceListViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var viewModel: ServiceListViewModel? {
        didSet { bind() }
    }
    private var dataSource: AppointmentServiceDiffableDataSource?
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceViewCell.self, forCellReuseIdentifier: ServiceViewCell.reuseIdentifier)
        tableView.delegate = self
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
        dataSource = AppointmentServiceDiffableDataSource(
            tableView: tableView,
            viewModel: viewModel,
            cellProvider: { tableView, indexPath, model in
                let cell = tableView.dequeueReusableCell(withIdentifier: ServiceViewCell.reuseIdentifier, for: indexPath) as! ServiceViewCell
                cell.configure(model: model)
                return cell
            }
        )
        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }

    private func setupView() {
        title = tr.servicesTitle
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind() {
        viewModel?.$services
            .receive(on: DispatchQueue.main)
            .sink { [weak self] prices in
                guard let self else { return }
                self.applySnapshot(prices: prices)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(prices: [Service]) {
        var snapshot = NSDiffableDataSourceSnapshot<StudioSection, Service>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(prices, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Add new Appointment Type
extension ServiceListViewController {
    
    @objc func addTapped() {
        viewModel?.addService()
    }
}

// MARK: - UITableViewDelegate - didSelectRowAt
extension ServiceListViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedService = dataSource?.itemIdentifier(for: indexPath) {
            viewModel?.serviceTapped(selectedService)
        }
    }
}
