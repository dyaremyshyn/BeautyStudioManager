//
//  AppointmentsViewCell.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//

import UIKit

class AppointmentsViewCell: UITableViewCell {
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
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var appointmentTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var appointmentDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var appointmentDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var inResidenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        clientNameLabel.text = ""
        appointmentTypeLabel.text = ""
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(appointmentDateLabel)
        containerView.addSubview(appointmentDurationLabel)
        containerView.addSubview(appointmentTypeLabel)
        containerView.addSubview(clientNameLabel)
        containerView.addSubview(inResidenceLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        appointmentDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        appointmentDurationLabel.topAnchor.constraint(equalTo: appointmentDateLabel.bottomAnchor, constant: 5).isActive = true
        appointmentDurationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
                
        appointmentTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        appointmentTypeLabel.trailingAnchor.constraint(equalTo: appointmentDateLabel.leadingAnchor, constant: -8).isActive = true
        
        clientNameLabel.topAnchor.constraint(equalTo: appointmentTypeLabel.bottomAnchor, constant: 5).isActive = true
        clientNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        clientNameLabel.trailingAnchor.constraint(equalTo: appointmentDateLabel.leadingAnchor, constant: -8).isActive = true
        
        
        inResidenceLabel.topAnchor.constraint(equalTo: clientNameLabel.bottomAnchor, constant: 5).isActive = true
        inResidenceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        inResidenceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        inResidenceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    public func configure(model: StudioAppointment) {
        clientNameLabel.text = model.name
        appointmentTypeLabel.text = model.type
        appointmentDateLabel.text = model.date.appointmentDate
        appointmentDurationLabel.text = model.date.appointmentDateTime + " - " + model.date.addingTimeInterval(3600).appointmentDateTime
        inResidenceLabel.text = model.inResidence ? "Ao domicílio" : .none
    }
}
