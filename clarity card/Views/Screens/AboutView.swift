import SwiftUI

struct AboutView: View {
    var body: some View {
        ScreenContainer {
            CardContainer {
                Text("About Clarity Card")
                    .font(.system(.title2, design: .rounded).weight(.bold))

                Text("This playground demonstrates how APR, payment size, and common credit-card terms affect total cost over time.")
                    .font(.system(.body, design: .rounded))
                Text("All calculations run locally and offline.")
                    .font(.system(.body, design: .rounded))
            }

            CardContainer {
                Text("Model assumptions")
                    .font(ClarityTheme.titleFont)
                Text("- Monthly rate uses APR/12.")
                Text("- Simulations cap at 600 months.")
                Text("- Results are educational estimates only.")
            }
            .font(.system(.subheadline, design: .rounded))

            CardContainer {
                Text("Credits")
                    .font(ClarityTheme.titleFont)
                Text("Built with SwiftUI and SF Symbols. No third-party assets used.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("About")
    }
}
