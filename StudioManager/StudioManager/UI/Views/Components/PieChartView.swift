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
            
            // Generate a random color for each type and save it to colorMap
            let color = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1.0
            )
            colorMap[type] = color
            color.setFill()
            path.fill()
            
            startAngle = endAngle
        }
        
        // Draw legend
        drawLegend()
    }

    private func drawLegend() {
        let legendX = bounds.minX
        var legendY = bounds.maxY + 15
        
        for (type, color) in colorMap {
            // Create a new UIView to draw the colored rectangle
            let colorView = UIView(frame: CGRect(x: legendX, y: legendY, width: 30, height: 30))
            colorView.backgroundColor = color
            addSubview(colorView)
            
            // Add the label next to the color view
            let label = UILabel(frame: CGRect(x: legendX + 40, y: legendY, width: 200, height: 25))
            label.text = type.rawValue
            label.font = .systemFont(ofSize: 14)
            addSubview(label)

            legendY += 40
        }
    }

}
