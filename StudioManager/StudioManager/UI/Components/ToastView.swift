//
//  ToastView.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 19/03/2025.
//

import SwiftUI

enum ToastType {
    case success
    case failure
}

enum ToastLengthType {
    case short
    case long
}

struct ToastView: View {
    let text: String
    @Binding var isVisible: Bool
    var type: ToastType = .success
    var lengthType: ToastLengthType = .short
    var image: String? = nil
    
    var body: some View {
        if isVisible {
            HStack {
                if let image {
                    Image(systemName: image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                Text(text)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(type.backgroundColor)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom, 16)
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + lengthType.duration) {
                    withAnimation {
                        isVisible = false
                    }
                }
            }
        }
    }
}

private extension ToastType {
    var backgroundColor: Color {
        switch self {
        case .success: return .Studio.success
        case .failure: return .Studio.warning
        }
    }
}

private extension ToastLengthType {
    var duration: Double {
        switch self {
        case .short: return 1.5
        case .long: return 3
        }
    }
}

private struct ToastModifier: ViewModifier {
    @Binding var isVisible: Bool
    let text: String
    let type: ToastType
    let lengthType: ToastLengthType
    let image: String?

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content

            if isVisible {
                ToastView(
                    text: text,
                    isVisible: $isVisible,
                    type: type,
                    lengthType: lengthType,
                    image: image
                )
                .transition(.opacity)
            }
        }
    }
}

extension View {
    func toast(
        isVisible: Binding<Bool>,
        text: String,
        type: ToastType = .success,
        image: String? = nil,
        lengthType: ToastLengthType = .short
    ) -> some View {
        self.modifier(
            ToastModifier(
                isVisible: isVisible,
                text: text,
                type: type,
                lengthType: lengthType,
                image: image
            )
        )
    }
}

#Preview {
    @Previewable @State var isSuccessToastVisible: Bool = false
    @Previewable @State var isFailureToastVisible: Bool = false

    NavigationStack{
        VStack{
            Button { isSuccessToastVisible.toggle() } label: {
                Text("Success Toast")
            }
            
            Button { isFailureToastVisible.toggle() } label: {
                Text("Failure Toast")
            }
        }
    }
    .toast(isVisible: $isSuccessToastVisible, text: "Success", image: "checkmark.circle")
    .toast(isVisible: $isFailureToastVisible, text: "Failure", type: .failure)
}
