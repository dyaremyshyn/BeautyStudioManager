//
//  StudioTheme.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/03/2025.
//

import Foundation

enum StudioTheme {
    /// 4pt
    static let spacing4 = 4.0
    /// 8pt
    static let spacing8 = 8.0
    /// 16pt
    static let spacing16 = 16.0
    /// 24pt
    static let spacing24 = 24.0
    /// 32pt
    static let spacing32 = 32.0
    /// 40pt
    static let spacing40 = 40.0

    /// Icon Size
    static let smallIconSize = 16.0
    static let mediumIconSize = 24.0
    static let bigIconSize = 64.0

    /// Text Field Height
    static let textFieldHeight = 44.0

    /// Corner Radius
    static let cr2: CGFloat = 2.0
    static let cr4: CGFloat = 4.0
    static let cr8: CGFloat = 8.0
    static let cr10: CGFloat = 10.0
    
    /// Opacity
    static let opacity06: CGFloat = 0.6
    static let opacity05: CGFloat = 0.5
    static let opacity01: CGFloat = 0.1
    
    /// Line Width
    static let lineWidth1: CGFloat = 1
    static let lineWidth2: CGFloat = 2
    
    /// Images
    static let emptyImage = "text.page.slash"
    static let successImage = "checkmark.circle"
    static let serviceDefaultImage = "default"
    static let addImage = "plus.circle.fill"
    static let listImage = "list.bullet.rectangle.portrait"
    static let errorImage = "xmark.circle"
    
    static let agendaImage = "list.bullet.clipboard"
    static let newAppointmentImage = "plus.circle" // "note.text.badge.plus"
    static let balanceImage = "chart.pie"
    static let servicesImage = "list.bullet.rectangle"
    static let settingsImage = "gearshape"
    static let addToCalendarImage = "calendar.badge.plus"
    static let addServiceImage = "plus"
    static let compareBalanceImage = "chart.xyaxis.line"
    
    /// Distance
    static let pricePerKm: Double = 0.4
    
    /// Duration
    static let defaultDuration = 3600.0
}
