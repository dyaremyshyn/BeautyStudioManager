//
//  ServiceViewCell.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 07/11/2024.
//

import UIKit

class ServiceViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ServiceViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var appointmentTypeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var appointmentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var appointmentDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
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
        appointmentTypeNameLabel.text = ""
        appointmentPriceLabel.text = ""
        appointmentDurationLabel.text = ""
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(appointmentTypeNameLabel)
        containerView.addSubview(appointmentDurationLabel)
        containerView.addSubview(appointmentPriceLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        appointmentPriceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        appointmentPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        appointmentPriceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        appointmentTypeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        appointmentTypeNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        appointmentTypeNameLabel.trailingAnchor.constraint(equalTo: appointmentPriceLabel.leadingAnchor, constant: -8).isActive = true
        
        appointmentDurationLabel.topAnchor.constraint(equalTo: appointmentTypeNameLabel.bottomAnchor, constant: 5).isActive = true
        appointmentDurationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        appointmentDurationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    public func configure(model: Service) {
        appointmentTypeNameLabel.text = model.type
        appointmentPriceLabel.text = "\(model.price)€"
        appointmentDurationLabel.text = formattedDuration(from: TimeInterval(floatLiteral: model.duration))
    }
}

extension ServiceViewCell {
    private func formattedDuration(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60 % 60
        let hours = Int(timeInterval) / 3600

        if hours > 0 {
            if minutes > 0 {
                return "\(hours) hora\(hours > 1 ? "s" : "") e \(minutes) minuto\(minutes > 1 ? "s" : "")"
            } else {
                return "\(hours) hora\(hours > 1 ? "s" : "")"
            }
        } else {
            return "\(minutes) minuto\(minutes > 1 ? "s" : "")"
        }
    }
}
