//
//  View+Extension.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import SwiftUI

extension View {
    /// frame(width: 12, height: 12)
    func smallSize() -> some View {
        return self.frame(width: 12, height: 12)
    }
    
    /// frame(width: 25, height: 25)
    func mediumSize() -> some View {
        return self.frame(width: 25, height: 25)
    }
    
    /// frame(width: 55, height: 55)
    func bigSize() -> some View {
        return self.frame(width: 55, height: 55)
    }
    
    /// frame(width: 60, height: 60)
    func veryBigSize() -> some View {
        return self.frame(width: 60, height: 60)
    }
}
