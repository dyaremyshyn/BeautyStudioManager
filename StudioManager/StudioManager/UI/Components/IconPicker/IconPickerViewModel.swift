//
//  IconPickerViewModel.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import Foundation
import SwiftUI

@Observable class IconPickerViewModel {
    var inputIcons: [String] = []
    var iconSections: [String: [String: [String]]] = [
        "makeup": [
            "makeup": ["makeup", "maquilhagem", "maquiagem", "embelezamento", "cosméticos", "estética"],
            "bride": ["bride", "casamento", "noiva", "noivo", "união", "noivas"],
        ],
        "hair": [
            "hairstyles": ["hair", "cabelo", "penteado", "penteados", "cabelos"],
        ],
        "nails": [
            "nails": ["nails", "unhas", "unhas verniz", "unhas verniz gel", "unhas de gel", "unhas gel", "gel", "verniz", "unhas acrilico", "unhas de acrilico", "acrilico"],
        ],
        "skin care": [
            "skincare": ["skincare", "pele", "cuidado com a pele", "limpeza da pele", "saúde da pele", "limpeza"],
        ],
        "lifting": [
            "lifting": ["lifting", "pestanas", "lifting de pestanas"],
        ],
        "eyebrows": [
            "eyebrows": ["eyebrows", "sobrancelhas", "sobrancelha", "sobrancelhas a linha"],
        ],
    ]
    var searchText: String = ""
    var pickerSearchText: String = ""
    
    var defaultIcons: [String] {
        iconSections.values.flatMap { $0.keys }
    }
    
    var iconFilter: [String] {
        let lowercaseInput = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        
        if lowercaseInput.isEmpty { return [StudioTheme.serviceDefaultImage] }
        
        let words = lowercaseInput.split(separator: " ").map { String($0) }
        var matchedIcons: [String] = []
        
        // Step 1: Check for exact phrase matches
        for (_, icons) in iconSections {
            for (icon, keywords) in icons {
                if keywords.contains(lowercaseInput) { return [icon] }
            }
        }
        
        // Step 2: Check for partial matches by iterating over words
        for word in words.reversed() {
            for (_, icons) in iconSections {
                for (icon, keywords) in icons where keywords.contains(word) {
                    if !matchedIcons.contains(icon) {
                        matchedIcons.append(icon)
                    }
                }
            }
        }
        
        // Step 3: Return prioritized matches (latest relevant word)
        return !matchedIcons.isEmpty ? matchedIcons : [StudioTheme.serviceDefaultImage]
    }
    
    func filteredSections(searchText: String) -> [String: [String]] {
        let lowercaseInput = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        var filteredSections: [String: [String]] = [:]
        
        for (section, icons) in iconSections {
            if lowercaseInput.isEmpty || section.lowercased().contains(lowercaseInput) {
                filteredSections[section] = Array(icons.keys)
            } else {
                let matchedIcons = icons.filter { (_, keywords) in
                    keywords.contains(where: { $0.contains(lowercaseInput) })
                }.map { $0.key }
                
                if !matchedIcons.isEmpty {
                    filteredSections[section] = matchedIcons
                }
            }
        }
        return filteredSections
    }
}
