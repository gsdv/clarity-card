import SwiftUI

struct PrimaryGlowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded).weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(ClarityTheme.glowGradient)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .shadow(color: ClarityTheme.accentCool.opacity(0.34), radius: 14, x: 0, y: 8)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}
