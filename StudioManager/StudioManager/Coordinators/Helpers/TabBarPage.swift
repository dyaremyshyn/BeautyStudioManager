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

    func getIndex() -> Int {
        switch self {
            case .agenda: return 0
            case .newAppointment: return 1
            case .balance: return 2
            case .services: return 3
        }
    }
    
    func getTitleName() -> String {
        switch self {
            case .agenda: return "Agenda"
            case .newAppointment: return "Nova Marcação"
            case .balance: return "Balanço"
            case .services: return "Serviços"
        }
    }
    
    func getIconName() -> String {
        switch self {
            case .agenda: return "list.bullet.clipboard"
            case .newAppointment: return "plus.circle"
            case .balance: return "chart.xyaxis.line"
            case .services: return "list.bullet.rectangle"
        }
    }
}
