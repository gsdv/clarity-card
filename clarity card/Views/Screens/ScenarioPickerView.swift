import SwiftUI

struct ScenarioPickerView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    let onSelect: (ScenarioType) -> Void

    var body: some View {
        ScreenContainer {
            Text("Choose Your Path")
                .font(.system(.largeTitle, design: .rounded).weight(.black))

            Text("Pick one scenario to get a focused next step")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)

            ForEach(viewModel.scenarios) { scenario in
                Button {
                    onSelect(scenario.type)
                } label: {
                    scenarioCard(scenario)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(scenario.title)
                .accessibilityHint(scenario.subtitle)
            }

            CardContainer {
                Label("Educational estimates only. Not financial advice.", systemImage: "info.circle")
                    .font(.system(.caption, design: .rounded).weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .toolbar {
            NavigationLink(value: AppRoute.about) {
                Image(systemName: "info.circle")
            }
            .accessibilityLabel("About and credits")
        }
    }

    private func scenarioCard(_ scenario: ScenarioCard) -> some View {
        let gradient = gradientForScenario(scenario.type)

        return ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(gradient)

            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.36), lineWidth: 1)

            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.22))
                        .frame(width: 52, height: 52)
                    Image(systemName: scenario.icon)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(scenario.title)
                        .font(.system(.headline, design: .rounded).weight(.bold))
                        .foregroundStyle(.white)
                    Text(scenario.subtitle)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.white.opacity(0.9))
                }

                Spacer(minLength: 10)
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.95))
            }
            .padding(18)
        }
        .frame(maxWidth: .infinity, minHeight: 136)
        .shadow(color: .black.opacity(0.15), radius: 16, x: 0, y: 10)
    }

    private func gradientForScenario(_ type: ScenarioType) -> LinearGradient {
        switch type {
        case .carryingBalance:
            return LinearGradient(colors: [ClarityTheme.accentCool, ClarityTheme.accentLime], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .minimumOnly:
            return LinearGradient(colors: [ClarityTheme.accentWarm, ClarityTheme.accentSun], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .choosingCard:
            return LinearGradient(colors: [ClarityTheme.accentCool, ClarityTheme.accentWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .glossary:
            return LinearGradient(colors: [ClarityTheme.accentLime, ClarityTheme.accentCool], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .knowledgeCheck:
            return LinearGradient(colors: [ClarityTheme.accentCoral, ClarityTheme.accentSun], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
