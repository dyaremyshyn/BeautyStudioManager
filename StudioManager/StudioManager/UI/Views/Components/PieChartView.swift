//
//  PieChartView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/10/2024.
//

import UIKit

class PieChartView: UIView {
    
    var appointmentAmounts: [String: Double]  // Amount for each appointment type
    
    public init(appointmentAmounts: [String: Double]) {
        self.appointmentAmounts = appointmentAmounts
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        self.appointmentAmounts = [:]
        super.init(coder: coder)
    }
    
    private var colorMap: [String: (UIColor,Double)] = [:]
    
    override func draw(_ rect: CGRect) {
        guard !appointmentAmounts.isEmpty else { return }

        let totalAmount = appointmentAmounts.values.reduce(0, +) // Sum all amounts
        
        var startAngle: CGFloat = -.pi / 2
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.5
        
        for (type, amount) in appointmentAmounts {
            let percentage = amount / totalAmount
            let endAngle = startAngle + CGFloat(percentage * 2 * .pi)
            let path = UIBezierPath()
            path.move(to: centerPoint)
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let color = ChartColorHelper.getColor(for: type)  // Assuming ChartColorHelper exists
            colorMap[type] = (color, amount)
            color.setFill()
            path.fill()
            
            startAngle = endAngle
        }
        
        // Draw legend
        drawLegend()
    }

    private func drawLegend() {
        let legendX = bounds.minX + 50
        var legendY = bounds.maxY + 5
        
        for (type, (color, amount)) in colorMap {
            // Create a new UIView to draw the colored rectangle
            let colorView = UIView(frame: CGRect(x: legendX, y: legendY, width: 15, height: 15))
            colorView.backgroundColor = color
            addSubview(colorView)
            
            // Add the label next to the color view
            let label = UILabel(frame: CGRect(x: legendX + 20, y: legendY, width: 200, height: 15))
            label.text = type + " \(amount)€"
            label.font = .systemFont(ofSize: 12)
            addSubview(label)

            legendY += 20
        }
    }
}
