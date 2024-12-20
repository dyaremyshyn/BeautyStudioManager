//
//  TabBarPage.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/10/2024.
//


enum TabBarPage {
    case appointments
    case newAppointment
    case balance
    case services

    func getIndex() -> Int {
        switch self {
            case .appointments: return 0
            case .newAppointment: return 1
            case .balance: return 2
            case .services: return 3
        }
    }
    
    func getTitleName() -> String {
        switch self {
            case .appointments: return "Marcações"
            case .newAppointment: return "Nova Marcação"
            case .balance: return "Balanço"
            case .services: return "Serviços"
        }
    }
    
    func getIconName() -> String {
        switch self {
            case .appointments: return "list.bullet.clipboard"
            case .newAppointment: return "plus.circle"
            case .balance: return "chart.xyaxis.line"
            case .services: return "list.bullet.rectangle"
        }
    }
}
