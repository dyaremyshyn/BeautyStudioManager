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
    let title: String?
    var icon: ImageResource? = nil
    var buttonType: StudioButtonType = .primary
    var enabled: Bool = true
    var destructive: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            buttonContents()
        })
        .disabled(!enabled)
        .tint(tintColor)
        .buttonStyle(.plain)
        .padding(.vertical, buttonType.verticalPadding)
        .padding(.horizontal, buttonType.horizontalPadding)
        .frame(maxWidth: buttonType.width)
        .background(RoundedRectangle(cornerRadius: StudioTheme.cr8).fill(backgroundShapeStyle()))
        .overlay(overlayShape())
        .opacity(enabled ? 1 : StudioTheme.opacity05)
    }
}

private extension StudioButton {
    @ViewBuilder func buttonContents() -> some View {
        switch buttonType {
        case .wrapIcon:
            getImage()
        default:
            HStack(spacing: StudioTheme.spacing8) {
                getImage()
                if let title {
                    Text(title)
                        .font(buttonType.font)
                        .foregroundStyle(textColor)
                }
            }
            .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder func getImage() -> some View {
        let iconSize = StudioTheme.mediumIconSize
        if let icon {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(iconColor)
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder func overlayShape() -> some View {
        switch buttonType {
        case .secondary, .bottomPage:
            RoundedRectangle(cornerRadius: StudioTheme.cr8)
                .stroke(destructive ? Color.Studio.warning : Color.Text.button, lineWidth: StudioTheme.lineWidth2)
        case .destructive:
            RoundedRectangle(cornerRadius: StudioTheme.cr8)
                .stroke(Color.Studio.warning, lineWidth: StudioTheme.lineWidth2)
        default:
            EmptyView()
        }
    }
}

private extension StudioButton {
    func backgroundShapeStyle() -> some ShapeStyle {
        if destructive { return .clear }
        
        switch buttonType {
        case .primary: return Color.Studio.icons
        case .bottomPage, .secondary, .tertiary, .wrapIcon: return Color.clear
        case .destructive: return Color.Studio.warning
        }
    }
    
    var tintColor: Color {
        if destructive { return .Studio.warning }

        switch buttonType {
        case .primary: return .Background._1
        case .bottomPage, .secondary, .tertiary, .wrapIcon: return .Studio.primary
        case .destructive: return .Studio.warning
        }
    }
    
    var textColor: Color {
        if destructive { return .Studio.warning }
        
        switch buttonType {
        case .primary, .destructive: return .white
        case .bottomPage, .secondary, .tertiary: return .Text.button
        case .wrapIcon: return .clear
        }
    }

    var iconColor: Color {
        if !enabled { return .Background.disabled }
        
        if destructive { return .Studio.warning }

        switch buttonType {
        case .primary: return .white
        case .bottomPage, .secondary, .tertiary, .wrapIcon, .destructive: return .Studio.primary
        }
    }
}

private extension StudioButtonType {
    var horizontalPadding: Double {
        switch self {
        case .primary, .secondary, .destructive, .bottomPage: return StudioTheme.spacing16
        case .tertiary, .wrapIcon: return StudioTheme.spacing8
        }
    }
    
    var verticalPadding: Double {
        switch self {
        case .primary: return StudioTheme.spacing16
        case .bottomPage, .secondary,.destructive: return StudioTheme.spacing8
        case .tertiary, .wrapIcon: return StudioTheme.spacing4
        }
    }
        
    var font: Font {
        switch self {
        case .primary: return .body.bold()
        case .tertiary: return .body
        case .destructive: return .body
        default: return .caption
        }
    }
    
    var width: CGFloat? {
        switch self {
        case .primary, .bottomPage: return .infinity
        default: return nil
        }
    }
}

#Preview {
    VStack{
        StudioButton(title: "Primary") { }
        StudioButton(title: "Secondary", buttonType: .secondary) { }
        StudioButton(title: "Tertiary", buttonType: .tertiary) { }
        StudioButton(title: "Destructive", buttonType: .destructive) { }
        StudioButton(title: "Destructive Secondary", buttonType: .secondary, destructive: true) { }
        StudioButton(title: nil, icon: .icon, buttonType: .wrapIcon) { }
        StudioButton(title: "Bottom Page", buttonType: .bottomPage) { }
    }
}
