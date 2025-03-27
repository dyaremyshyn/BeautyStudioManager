//
//  CGColor+Extension.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 27/03/2025.
//

import UIKit

extension CGColor {
    var archiveColor: Data? {
        let uiColor = UIColor(cgColor: self)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            return data
        } catch {
            print("Error archiving color: \(error)")
            return nil
        }
    }
    
    static var random: CGColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
    }
}
