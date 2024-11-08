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
    case pricingTable

    func getIndex() -> Int {
        switch self {
            case .appointments: return 0
            case .newAppointment: return 1
            case .balance: return 2
            case .pricingTable: return 3
        }
    }
    
    func getTitleName() -> String {
        switch self {
            case .appointments: return "Marcações"
            case .newAppointment: return "Nova Marcação"
            case .balance: return "Balanço"
            case .pricingTable: return "Tabela de Preços"
        }
    }
    
    func getIconName() -> String {
        switch self {
            case .appointments: return "list.bullet.clipboard"
            case .newAppointment: return "plus.circle"
            case .balance: return "chart.xyaxis.line"
            case .pricingTable: return "dollarsign.bank.building"
        }
    }
}
