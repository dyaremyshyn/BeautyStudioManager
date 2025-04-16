//
//  TypingText.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 09/04/2025.
//


import SwiftUI

struct TypingText<Content: View>: View {
    var text: String
    @Binding var animate: Bool
    @ViewBuilder var content: () -> Content
    @State private var displayedText = ""
    @State private var currentCharacterIndex: String.Index!
    @State private var typingTimer: Timer? = nil
    
    var body: some View {
        VStack{
            Text(displayedText)
                .font(.subheadline)
                .padding(.horizontal)
            
            if displayedText == text {
                content()
                    .transition(.opacity)
                    .padding(.vertical)
            }
        }
        .onChange(of: animate) { _, _ in
            if animate {
                startTypingEffect()
            } else {
                stopTypingEffect()
            }
        }
        .onDisappear {
            stopTypingEffect()
            displayedText = ""
        }
    }
    
    private func startTypingEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            currentCharacterIndex = text.startIndex
            displayedText = ""
            typingTimer?.invalidate()
            typingTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                if currentCharacterIndex < text.endIndex {
                    displayedText.append(text[currentCharacterIndex])
                    currentCharacterIndex = text.index(after: currentCharacterIndex)
                } else {
                    timer.invalidate()
                    typingTimer = nil
                }
            }
        }
    }
    
    private func stopTypingEffect() {
        typingTimer?.invalidate()
        typingTimer = nil
    }
}

#Preview {
    @Previewable @State var animate: Bool = true
    let description = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."

    Button("Toggle") { animate.toggle() }
    TypingText(text: description, animate: $animate) {
        HStack {
            Image(systemName: StudioTheme.addToCalendarImage)
            Text("Content goes here.")
        }
    }
}
