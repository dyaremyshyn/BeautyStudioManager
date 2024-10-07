//
//  AppointmentsViewCell.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//

import UIKit

class AppointmentsViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: AppointmentsViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var clientNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var appointmentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var appointmentsDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var inResidenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        clientNameLabel.text = ""
        appointmentsLabel.text = ""
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(clientNameLabel)
        containerView.addSubview(appointmentsLabel)
        containerView.addSubview(appointmentsDurationLabel)
        containerView.addSubview(inResidenceLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        clientNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        clientNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        clientNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        appointmentsLabel.topAnchor.constraint(equalTo: clientNameLabel.bottomAnchor, constant: 5).isActive = true
        appointmentsLabel.leadingAnchor.constraint(equalTo: clientNameLabel.leadingAnchor, constant: 8).isActive = true
        appointmentsLabel.trailingAnchor.constraint(equalTo: clientNameLabel.trailingAnchor, constant: -8).isActive = true
        
        appointmentsDurationLabel.topAnchor.constraint(equalTo: appointmentsLabel.bottomAnchor, constant: 5).isActive = true
        appointmentsDurationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        appointmentsDurationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        inResidenceLabel.topAnchor.constraint(equalTo: appointmentsDurationLabel.bottomAnchor, constant: 5).isActive = true
        inResidenceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        inResidenceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        inResidenceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    
}
    
extension AppointmentsViewCell {
    public func configure(model: Client?) {
        var appointments: String = ""
        model?.appointments.forEach {
            appointments += $0.type + "\n"
        }
        
        clientNameLabel.text = model?.name
        appointmentsLabel.text = appointments
        appointmentsDurationLabel.text = "\(model?.appointments.first?.date) - \(model?.appointments.last?.date)"
        inResidenceLabel.text = model?.appointments.first(where: { $0.inResidence }) != nil ? "Yes" : "No"
    }
}
