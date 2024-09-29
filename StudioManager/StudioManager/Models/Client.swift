//
//  Client.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 22/09/2024.
//

import Foundation

struct Client: Equatable, Identifiable {
    let id: UUID
    let name: String
    let phoneNumber: String?
    let appointments: [Appointment]
    
    func initials() -> String {
        let words = name.components(separatedBy: " ")
        var initials = ""
        for word in words {
            if let firstCharacter = word.first {
                initials.append(firstCharacter)
            }
        }
        return initials.uppercased()
    }
    
    public static func map(client: ClientEntity) -> Client {
        Client(
            id: client.id ?? UUID(),
            name: client.name ?? "",
            phoneNumber: client.phoneNumber,
            appointments: client.appointments?.allObjects as? [Appointment] ?? []
        )
    }
}
