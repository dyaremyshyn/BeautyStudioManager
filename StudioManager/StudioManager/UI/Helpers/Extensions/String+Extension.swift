//
//  String+Extension.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 17/04/2025.
//

import Foundation

extension String {
    func onlyDigits() -> String {
        filter { $0.isWholeNumber }
    }
}
