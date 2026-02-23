import SwiftUI

enum ClarityTheme {
    static let accentCool = Color(red: 0.14, green: 0.66, blue: 0.27)
    static let accentLime = Color(red: 0.76, green: 0.9, blue: 0.2)
    static let accentWarm = Color(red: 0.95, green: 0.55, blue: 0.17)
    static let accentSun = Color(red: 0.96, green: 0.78, blue: 0.2)
    static let accentCoral = Color(red: 0.89, green: 0.29, blue: 0.24)

    static let panelGradient = LinearGradient(
        colors: [
            Color(uiColor: .secondarySystemBackground).opacity(0.92),
            Color(uiColor: .tertiarySystemBackground).opacity(0.78)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let glowGradient = LinearGradient(
        colors: [accentCool, accentLime],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let heroFont = Font.system(size: 42, weight: .black, design: .rounded)
}
