//
//  Array+CountOccurrences.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/10/2024.
//

extension Array where Element == AppointmentType {
    func countOccurrences() -> [AppointmentType: Int] {
        var counts: [AppointmentType: Int] = [:]
        for type in self {
            counts[type, default: 0] += 1
        }
        return counts
    }
}
