//
//  ServiceImage.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 21/03/2025.
//

import SwiftUI

struct ServiceImage: View {
    let icon: String
    
    var body: some View {
        Image(icon)
            .font(.title)
            .bigSize()
            .background(.ultraThinMaterial, in: Circle())
    }
}

#Preview {
    ServiceImage(icon: StudioTheme.serviceDefaultImage)
}
