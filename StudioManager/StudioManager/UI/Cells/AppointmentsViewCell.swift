//
//  AppointmentsViewCell.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 29/09/2024.
//

import UIKit
import SwiftUI

class AppointmentsViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: AppointmentsViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = CardView()
        return view
    }()
    
    private lazy var clientNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var appointmentTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private lazy var appointmentDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private lazy var appointmentDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var inResidenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var iconHostingController: UIHostingController<ServiceImage> = {
        let hostingController = UIHostingController(rootView: ServiceImage(icon: StudioTheme.serviceDefaultImage))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
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
        iconHostingController.rootView = ServiceImage(icon: StudioTheme.serviceDefaultImage)

    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(iconHostingController.view)
        containerView.addSubview(appointmentDateLabel)
        containerView.addSubview(appointmentDurationLabel)
        containerView.addSubview(appointmentTypeLabel)
        containerView.addSubview(clientNameLabel)
        containerView.addSubview(inResidenceLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        iconHostingController.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        iconHostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        iconHostingController.view.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iconHostingController.view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        appointmentDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        appointmentDurationLabel.topAnchor.constraint(equalTo: appointmentDateLabel.bottomAnchor, constant: 5).isActive = true
        appointmentDurationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
                
        appointmentTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentTypeLabel.leadingAnchor.constraint(equalTo: iconHostingController.view.trailingAnchor, constant: 8).isActive = true
        appointmentTypeLabel.trailingAnchor.constraint(equalTo: appointmentDateLabel.leadingAnchor, constant: -8).isActive = true
        
        clientNameLabel.topAnchor.constraint(equalTo: appointmentTypeLabel.bottomAnchor, constant: 5).isActive = true
        clientNameLabel.leadingAnchor.constraint(equalTo: iconHostingController.view.trailingAnchor, constant: 8).isActive = true
        clientNameLabel.trailingAnchor.constraint(equalTo: appointmentDateLabel.leadingAnchor, constant: -8).isActive = true
        
        inResidenceLabel.topAnchor.constraint(equalTo: clientNameLabel.bottomAnchor, constant: 5).isActive = true
        inResidenceLabel.leadingAnchor.constraint(equalTo: iconHostingController.view.trailingAnchor, constant: 8).isActive = true
        inResidenceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        inResidenceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    public func configure(model: StudioAppointment) {
        clientNameLabel.text = model.name
        appointmentTypeLabel.text = model.type
        appointmentDateLabel.text = model.date.appointmentDate
        appointmentDurationLabel.text = model.date.appointmentDateTime + " - " + model.endDate.appointmentDateTime
        inResidenceLabel.text = model.inResidence ? tr.appointmentAtHome : .none
        iconHostingController.rootView = ServiceImage(icon: model.icon)
    }
}
