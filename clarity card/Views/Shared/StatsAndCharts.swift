import SwiftUI
import Charts

struct StatBlock: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(.title3, design: .rounded).weight(.bold))
                .foregroundStyle(.primary)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.white.opacity(0.3))
        )
    }
}

struct PayoffOrbitView: View {
    let months: Int?
    let showNoPayoffState: Bool

    var body: some View {
        let value = min(Double(months ?? 600) / 600, 1)
        let progress = showNoPayoffState ? 1.0 : (1 - value)
        let payoffAccessibilityMonths = months.map(String.init) ?? "over 600"

        ZStack {
            Circle()
                .stroke(.white.opacity(0.32), lineWidth: 10)
            if showNoPayoffState {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(ClarityTheme.accentCoral, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            } else {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(ClarityTheme.glowGradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }

            VStack(spacing: 2) {
                Text(showNoPayoffState ? "No payoff" : (months.map(String.init) ?? "600+"))
                    .font(
                        showNoPayoffState
                            ? .system(.headline, design: .rounded).weight(.bold)
                            : .system(.title3, design: .rounded).weight(.bold)
                    )
                Text(showNoPayoffState ? "trajectory" : "months")
                    .font(.system(.caption2, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 92, height: 92)
        .accessibilityLabel(showNoPayoffState ? "No full payoff trajectory" : "Months to payoff \(payoffAccessibilityMonths)")
    }
}

struct ComparisonChartView: View {
    let scenarios: [ComparisonScenario]

    var body: some View {
        CardContainer {
            Text("Impact Board")
                .font(ClarityTheme.titleFont)
            Text("Lower columns mean faster payoff")
                .font(.caption)
                .foregroundStyle(.secondary)

            Chart(scenarios) { item in
                BarMark(
                    x: .value("Plan", item.label),
                    y: .value("Months", item.result.monthsToPayoff ?? 600)
                )
                .cornerRadius(7)
                .foregroundStyle(
                    LinearGradient(
                        colors: [color(for: item.label), color(for: item.label).opacity(0.45)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                RuleMark(y: .value("10 years", 120))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundStyle(.secondary.opacity(0.35))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 240)

            HStack(spacing: 8) {
                legend("Current", color: color(for: "Current"))
                legend("+25", color: color(for: "+$25"))
                legend("+50", color: color(for: "+$50"))
                legend("Custom", color: color(for: "Your extra"))
            }
            .font(.caption2)
        }
    }

    private func legend(_ text: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(text)
        }
    }

    private func color(for label: String) -> Color {
        switch label {
        case "Current": return ClarityTheme.accentWarm
        case "+$25": return ClarityTheme.accentCool
        case "+$50": return ClarityTheme.accentLime
        default: return ClarityTheme.accentSun
        }
    }
}
