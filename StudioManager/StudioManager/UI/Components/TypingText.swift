//
//  TypingText.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 09/04/2025.
//


import SwiftUI

struct TypingText: View {
    var text: String
    @Binding var isExpanded: Bool
    @State private var displayedText = ""
    @State private var currentCharacterIndex: String.Index!
    
    var body: some View {
        VStack{
            Text(displayedText)
                .font(.subheadline)
                .padding(.horizontal)
        }
        .onChange(of: isExpanded) { _, newValue in
            if newValue {
                startTypingEffect()
            }
        }
    }
    
    private func startTypingEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            currentCharacterIndex = text.startIndex
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                displayedText.append(text[currentCharacterIndex])
                currentCharacterIndex = text.index(after: currentCharacterIndex)
                
                if currentCharacterIndex == text.endIndex {
                    timer.invalidate()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isExpanded: Bool = true
    let description = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."

    Button("Toggle") { isExpanded.toggle() }
    TypingText(text: description, isExpanded: $isExpanded)
    
}
