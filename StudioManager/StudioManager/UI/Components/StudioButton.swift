//
//  StudioButton.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/03/2025.
//

import SwiftUI

enum StudioButtonType {
    case primary
    case secondary
    case tertiary
    case destructive
    case wrapIcon
    case bottomPage
}

struct StudioButton: View {
    let title: String
    var icon: String? = nil
    var buttonType: StudioButtonType = .primary
    var enabled: Bool = true
    var destructive: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            buttonContents()
        }
        .disabled(!enabled)
        .opacity(enabled ? 1 : StudioTheme.opacity05)
        .padding(.horizontal)
    }
}

private extension StudioButton {
    @ViewBuilder func buttonContents() -> some View {
        switch buttonType {
        case .wrapIcon: wrapIcon()
        default:
            if let icon {
                Label(title, systemImage: icon)
                    .frame(maxWidth: buttonType.width)
                    .padding()
                    .foregroundColor(textColor)
                    .background(backgroundColor)
                    .clipShape(.capsule)
            } else {
                Text(title)
                    .frame(maxWidth: buttonType.width)
                    .padding()
                    .foregroundColor(textColor)
                    .background(backgroundColor)
                    .clipShape(.capsule)
            }
        }
    }
    
    @ViewBuilder func wrapIcon() -> some View {
        if let icon {
            Image(systemName: icon)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(iconColor)
                .scaledToFit()
                .mediumSize()
        } else {
            EmptyView()
        }
    }
}

private extension StudioButton {
    var backgroundColor: Color {
        if destructive { return .Studio.warning }
        
        switch buttonType {
        case .primary, .secondary: return .blue
        case .bottomPage: return .Studio.icons
        case .tertiary, .wrapIcon: return .clear
        case .destructive: return .Studio.warning
        }
    }
    
    var textColor: Color {
        if destructive { return .white }
        
        switch buttonType {
        case .tertiary:  return .Text.button
        case .wrapIcon: return .clear
        default: return .white
        }
    }

    var iconColor: Color {
        if !enabled { return .Background.disabled }
        
        if destructive { return .Studio.warning }

        switch buttonType {
        case .primary: return .white
        case .bottomPage, .secondary, .tertiary, .wrapIcon, .destructive: return .Text.button
        }
    }
}

private extension StudioButtonType {
    var width: CGFloat? {
        switch self {
        case .primary, .bottomPage: return .infinity
        default: return nil
        }
    }
}

#Preview {
    VStack{
        StudioButton(title: "Primary", icon: StudioTheme.listImage) { }
        StudioButton(title: "Secondary", buttonType: .secondary) { }
        StudioButton(title: "Tertiary", buttonType: .tertiary) { }
        StudioButton(title: "Destructive", buttonType: .destructive) { }
        StudioButton(title: "", icon: "eraser", buttonType: .wrapIcon) { }
        StudioButton(title: "Bottom Page", buttonType: .bottomPage) { }
        StudioButton(title: "Disabled", buttonType: .secondary, enabled: false) { }
        
        HStack {
            StudioButton(title: "View Expenses", icon: StudioTheme.listImage, buttonType: .secondary) { }
            StudioButton(title: "View Expenses", icon: StudioTheme.listImage, buttonType: .secondary) { }
        }
    }
    .frame(maxWidth: .infinity)
}
