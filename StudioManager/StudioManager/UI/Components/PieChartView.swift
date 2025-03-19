//
//  PieChartView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/10/2024.
//

import UIKit

class PieChartView: UIView {
    
    // Amount for each appointment type
    var appointmentAmounts: [String: Double] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var slices: [(type: String, color: UIColor, amount: Double)] = []

    private let legendContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(appointmentAmounts: [String: Double]) {
        self.appointmentAmounts = appointmentAmounts
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setupLegendContainer()
    }
    
    required init?(coder: NSCoder) {
        self.appointmentAmounts = [:]
        super.init(coder: coder)
        setupLegendContainer()
    }
    
    private func setupLegendContainer() {
        addSubview(legendContainer)
        legendContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        legendContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        legendContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
        
    override func draw(_ rect: CGRect) {
        guard !appointmentAmounts.isEmpty else {
            slices = []
            return
        }
        
        guard let _ = UIGraphicsGetCurrentContext() else { return }
        
        let totalAmount = appointmentAmounts.values.reduce(0, +)
        var startAngle: CGFloat = -.pi / 2
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.5
        
        var computedSlices: [(type: String, color: UIColor, amount: Double)] = []
        
        // Draw each pie slice
        for (type, amount) in appointmentAmounts {
            let percentage = amount / totalAmount
            let endAngle = startAngle + CGFloat(percentage * 2 * .pi)
            
            let path = UIBezierPath()
            path.move(to: centerPoint)
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let color = ChartColorHelper.getColor(for: type)
            color.setFill()
            path.fill()
            
            computedSlices.append((type: type, color: color, amount: amount))
            startAngle = endAngle
        }
        
        // Cache slices and update legend
        self.slices = computedSlices
        updateLegend()
    }

    private func updateLegend() {
        legendContainer.subviews.forEach { $0.removeFromSuperview() }
        
        var yOffset: CGFloat = 0
        
        for slice in slices {
            // Create a colored square for the legend
            let colorView = UIView(frame: CGRect(x: 0, y: yOffset, width: 15, height: 15))
            colorView.backgroundColor = slice.color
            legendContainer.addSubview(colorView)
            
            // Create a label next to the color view
            let label = UILabel(frame: CGRect(x: 20, y: yOffset, width: legendContainer.bounds.width - 20, height: 15))
            label.text = "\(slice.type) \(slice.amount)€"
            label.font = .systemFont(ofSize: 12)
            legendContainer.addSubview(label)
            
            yOffset += 20
        }
    }
}
