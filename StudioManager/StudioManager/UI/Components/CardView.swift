//
//  CardView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import UIKit

final class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = StudioTheme.cr10
        backgroundColor = .systemBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}
