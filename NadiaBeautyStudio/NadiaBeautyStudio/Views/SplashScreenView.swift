//
//  SplashScreenView.swift
//  NadiaBeautyStudio
//
//  Created by Dmytro Yaremyshyn on 17/05/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State var imageOpacity: Double = 0.0
    @State var stackOpacity: Double = 1.0
    @State var scaleImage = CGSize(width: 1, height: 1)

    @Binding var isPesented: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                ZStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .opacity(imageOpacity)
                }
                .scaleEffect(scaleImage)
            }
            .opacity(stackOpacity)
            .onAppear {
                startAnimation()
            }
        }
    }
    
    func startAnimation() {
        withAnimation(.easeInOut(duration: 1.5)) {
            imageOpacity = 1.0
        }
        // Blink animation
        for i in 0..<8 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + Double(i) * 0.1) {
                imageOpacity = imageOpacity == 0.0 ? 1 : 0.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            withAnimation(.easeIn(duration: 0.35)) {
                scaleImage = CGSize(width: 50, height: 50)
                stackOpacity = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            withAnimation(.easeIn(duration: 0.2)) {
                isPesented.toggle()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isPesented: .constant(true))
    }
}
