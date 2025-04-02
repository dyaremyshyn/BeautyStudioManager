//
//  DonutChartView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 02/04/2025.
//

import SwiftUI
import Charts

struct DonutChartView: View {
    let serviceRevenues: [ServiceRevenue]
    
    var body: some View {
        Chart {
            ForEach(serviceRevenues) { service in
                SectorMark(
                    angle: .value(tr.revenue, service.revenue),
                    innerRadius: .ratio(0.6),
                    angularInset: 2.0
                )
                .foregroundStyle(service.color)
            }
        }
        .frame(height: 220)
        .padding()
        
        VStack(alignment: .leading, spacing: 8) {
            ForEach(serviceRevenues) { service in
                HStack {
                    Circle()
                        .fill(service.color)
                        .frame(width: 12, height: 12)
                    Text(formatServiceRevenue(service.service, service.revenue))
                        .font(.body)
                }
            }
        }
    }
    
    private func formatServiceRevenue(_ service: String, _ revenue: Double) -> String {
        String(format: "%@: €%.2f", service, revenue)
    }
}

#Preview {
    DonutChartView(
        serviceRevenues: [
            ServiceRevenue(service: "Makeup", revenue: 250, color: UIColor.systemPink.cgColor),
            ServiceRevenue(service: "Skincare", revenue: 70, color: UIColor.blue.cgColor),
            ServiceRevenue(service: "Nails", revenue: 345, color: UIColor.green.cgColor),
        ]
    )
}
