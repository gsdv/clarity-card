import SwiftUI

struct AuroraBackground: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var animate = false

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height

            ZStack {
                LinearGradient(
                    colors: [
                        Color(uiColor: .systemBackground),
                        Color(uiColor: .secondarySystemBackground)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(ClarityTheme.accentCool.opacity(0.22))
                    .frame(width: width * 0.9)
                    .blur(radius: 28)
                    .offset(x: animate ? -width * 0.15 : width * 0.2, y: animate ? -height * 0.2 : -height * 0.08)

                Circle()
                    .fill(ClarityTheme.accentWarm.opacity(0.18))
                    .frame(width: width * 0.72)
                    .blur(radius: 34)
                    .offset(x: animate ? width * 0.18 : -width * 0.22, y: animate ? height * 0.2 : height * 0.32)

                Circle()
                    .fill(ClarityTheme.accentCoral.opacity(0.13))
                    .frame(width: width * 0.7)
                    .blur(radius: 40)
                    .offset(x: animate ? width * 0.25 : -width * 0.1, y: animate ? -height * 0.05 : height * 0.15)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 13).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}
