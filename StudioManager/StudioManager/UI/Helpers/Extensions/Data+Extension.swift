//
//  Data+Extension.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import Foundation
import CoreGraphics
import UIKit

extension Data {
    var unarchiveColor: CGColor? {
        do {
            let uiColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: self)
            return uiColor?.cgColor
        } catch {
            print("Error unarchiving color: \(error)")
            return nil
        }
    }
}
