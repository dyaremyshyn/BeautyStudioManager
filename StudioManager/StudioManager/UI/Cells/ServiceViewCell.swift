//
//  ServiceViewCell.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 07/11/2024.
//

import UIKit
import SwiftUI

class ServiceViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ServiceViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = CardView()
        return view
    }()
    
    private lazy var appointmentTypeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .label
        return label
    }()
    
    private lazy var appointmentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .Studio.success
        return label
    }()
    
    private lazy var appointmentDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
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
        appointmentTypeNameLabel.text = ""
        appointmentPriceLabel.text = ""
        appointmentDurationLabel.text = ""
        iconHostingController.rootView = ServiceImage(icon: StudioTheme.serviceDefaultImage)
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(iconHostingController.view)
        containerView.addSubview(appointmentTypeNameLabel)
        containerView.addSubview(appointmentDurationLabel)
        containerView.addSubview(appointmentPriceLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        iconHostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        iconHostingController.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        iconHostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        iconHostingController.view.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iconHostingController.view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        iconHostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        
        appointmentPriceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        appointmentPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        appointmentPriceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        appointmentTypeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentTypeNameLabel.leadingAnchor.constraint(equalTo: iconHostingController.view.trailingAnchor, constant: 8).isActive = true
        appointmentTypeNameLabel.trailingAnchor.constraint(equalTo: appointmentPriceLabel.leadingAnchor, constant: -8).isActive = true
        
        appointmentDurationLabel.topAnchor.constraint(equalTo: appointmentTypeNameLabel.bottomAnchor, constant: 5).isActive = true
        appointmentDurationLabel.leadingAnchor.constraint(equalTo: iconHostingController.view.trailingAnchor, constant: 8).isActive = true
        appointmentDurationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    func configure(model: Service) {
        appointmentTypeNameLabel.text = model.type
        appointmentPriceLabel.text = "\(model.price)€"
        appointmentDurationLabel.text = DurationConverter.formattedDuration(model.duration)
        iconHostingController.rootView = ServiceImage(icon: model.icon)
    }
}
