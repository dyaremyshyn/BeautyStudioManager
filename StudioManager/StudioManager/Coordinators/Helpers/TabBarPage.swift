//
//  TabBarPage.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//


enum TabBarPage {
    case agenda
    case newAppointment
    case balance
    case services
    case settings

    func getIndex() -> Int {
        switch self {
        case .agenda: return 0
        case .balance: return 1
        case .newAppointment: return 2
        case .services: return 3
        case .settings: return 4
        }
    }
    
    func getTitleName() -> String {
        switch self {
        case .agenda: return tr.agendaTitle
        case .newAppointment: return tr.newAppointmentTitle
        case .balance: return tr.balanceTitle
        case .services: return tr.servicesTitle
        case .settings: return tr.settingsTitle
        }
    }
    
    func getIconName() -> String {
        switch self {
        case .agenda: return "list.bullet.clipboard"
        case .newAppointment: return "note.text.badge.plus" //"plus.circle"
        case .balance: return "chart.xyaxis.line"
        case .services: return "list.bullet.rectangle"
        case .settings: return "gearshape"
        }
    }
}
