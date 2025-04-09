//
//  OnboardingView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 09/04/2025.
//

import SwiftUI

struct OnboardingView: View {
    let imageName: String
    let title: String
    let description: String
    
    @State private var imageVisible: Bool = false
    @State private var textVisible: Bool = false


    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: imageName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 150)
                .foregroundStyle(Color.Text.button)
                .opacity(imageVisible ? 1 : 0)
                .scaleEffect(imageVisible ? 1 : 0.8)
                .animation(.easeOut(duration: 0.6), value: imageVisible)
                .padding(.bottom, 20)

            if textVisible {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .transition(.opacity)
                    .padding(.bottom, 5)
                Text(description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .transition(.opacity)
            }
            Spacer()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                imageVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation(.easeIn(duration: 0.6)) {
                    textVisible = true
                }
            }
        }
    }
}

#Preview {
    let description = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    OnboardingView(imageName: "list.bullet.clipboard", title: "Title", description: description)
}
