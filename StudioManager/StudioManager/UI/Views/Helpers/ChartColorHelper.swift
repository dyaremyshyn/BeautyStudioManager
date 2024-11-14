//
//  ChartColorHelper.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 23/10/2024.
//

import Foundation
import UIKit

struct ChartColorHelper {
    
    public static func getColor(for type: String) -> UIColor {
        switch type {
        default:return UIColor.random()
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
