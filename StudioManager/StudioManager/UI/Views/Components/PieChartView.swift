//
//  PieChartView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/10/2024.
//

import UIKit

class PieChartView: UIView {
    
    var appointmentTypes: [AppointmentType]
    
    public init(appointmentTypes: [AppointmentType]) {
        self.appointmentTypes = appointmentTypes
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        self.appointmentTypes = []
        super.init(coder: coder)        
    }
    
    private var colorMap: [AppointmentType: UIColor] = [:]
        
    override func draw(_ rect: CGRect) {
        guard appointmentTypes.count > 0 else { return }
        
        let countedTypes = appointmentTypes.countOccurrences() // Counts each type

        let totalAppointments = appointmentTypes.count
        var startAngle: CGFloat = -.pi / 2
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.5
        
        for (type, count) in countedTypes {
            let endAngle = startAngle + (CGFloat(count) / CGFloat(totalAppointments)) * 2 * .pi
            let path = UIBezierPath()
            path.move(to: centerPoint)
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let color = ChartColorHelper.getColor(for: type)
            colorMap[type] = color
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
        
        for (type, color) in colorMap {
            // Create a new UIView to draw the colored rectangle
            let colorView = UIView(frame: CGRect(x: legendX, y: legendY, width: 15, height: 15))
            colorView.backgroundColor = ChartColorHelper.getColor(for: type)
            addSubview(colorView)
            
            // Add the label next to the color view
            let label = UILabel(frame: CGRect(x: legendX + 20, y: legendY, width: 200, height: 15))
            label.text = type.rawValue
            label.font = .systemFont(ofSize: 12)
            addSubview(label)

            legendY += 20
        }
    }

}
