//
//  BalanceView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 25/03/2025.
//

import UIKit

enum BalanceType {
    case income
    case expense
}

final class BalanceView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var amount: String {
        get {
            amountLabel.text ?? ""
        } set {
            amountLabel.text = newValue
        }
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addConstraints()
    }
    
    public init(title: String, type: BalanceType) {
        super.init(frame: .zero)
        setupView(title, type)
        addConstraints()
    }
    
    private func setupView(_ title: String, _ type: BalanceType) {
        titleLabel.text = title
        titleLabel.textColor = type == .income ? .systemGreen : .systemRed
        amountLabel.textColor = type == .income ? .systemGreen : .systemRed
    }
    
    private func addConstraints() {
        addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
