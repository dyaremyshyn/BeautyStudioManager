//
//  EmptyView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 20/12/2024.
//

import SwiftUI

struct EmptyView<Content: View>: View {
    var imageName: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .center, content: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
                .padding()
            content()
                .font(.headline)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        })
    }
}

#Preview {
    EmptyView(imageName: "text.page.slash") {
        Text("Não há nenhum serviço introduzido! \nAdicione um serviço para começar a introduzir as marcações")
    }
}
