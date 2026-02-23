import SwiftUI

struct WelcomeView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var iconPulse = false
    let onStart: () -> Void

    var body: some View {
        ZStack {
            AuroraBackground()

            VStack(alignment: .leading, spacing: 20) {
                Spacer(minLength: 10)

                Text("Clarity Card")
                    .font(ClarityTheme.heroFont)
                    .foregroundStyle(.primary)
                    .accessibilityAddTraits(.isHeader)

                Text("Turn confusing credit terms into clear decisions.")
                    .font(.system(.title3, design: .rounded).weight(.semibold))

                Text("A guided, offline, 3-minute experience for payoff planning, card choices, and key terms.")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)

                HStack(spacing: 14) {
                    Image(systemName: "sparkles.rectangle.stack")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(ClarityTheme.glowGradient)
                        .scaleEffect(iconPulse ? 1.05 : 0.95)
                        .opacity(iconPulse ? 1 : 0.75)
                        .accessibilityHidden(true)

                    Text("Understand cost first. Decide your next step with confidence.")
                        .font(.system(.subheadline, design: .rounded).weight(.medium))
                        .foregroundStyle(.secondary)
                }
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.ultraThinMaterial)
                )

                Button("Start") {
                    onStart()
                }
                .buttonStyle(PrimaryGlowButtonStyle())
                .accessibilityLabel("Start Clarity Card")

                Spacer(minLength: 14)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 30)
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                iconPulse = true
            }
        }
    }

}
