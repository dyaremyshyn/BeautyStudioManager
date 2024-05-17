//
//  ContainerView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 17/05/2024.
//

import SwiftUI

struct ContainerView: View {
    @State private var isSplashViewPesented = true
    
    var body: some View {
        if !isSplashViewPesented {
            AppointmentsView()
        } else {
            SplashScreenView(isPesented: $isSplashViewPesented)
        }
    }
}

#Preview {
    ContainerView()
}
