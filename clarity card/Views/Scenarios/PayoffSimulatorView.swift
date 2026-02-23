import SwiftUI

struct PayoffSimulatorView: View {
    @StateObject private var viewModel: PayoffViewModel

    init(mode: PayoffMode) {
        _viewModel = StateObject(wrappedValue: PayoffViewModel(mode: mode))
    }

    var body: some View {
        ScreenContainer {
            headlineCard
            inputsCard
            if viewModel.mode == .standard {
                sliderCard
                ComparisonChartView(scenarios: viewModel.comparisonScenarios)
            }
            nextStepsCard
            assumptionsCard
        }
        .navigationTitle(viewModel.mode == .standard ? "Payoff Studio" : "Minimum Reality")
    }

    private var headlineCard: some View {
        CardContainer {
            HStack(alignment: .top, spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.mode == .standard ? "Your current pace" : "Minimum-payment outlook")
                        .font(ClarityTheme.titleFont)

                    Text(viewModel.payoffHeadline)
                        .font(.system(.title3, design: .rounded).weight(.bold))
                }

                Spacer(minLength: 8)
                PayoffOrbitView(
                    months: viewModel.baseResult.monthsToPayoff,
                    showNoPayoffState: viewModel.noPayoffTrajectory
                )
            }

            Text(viewModel.coachingText)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if viewModel.noPayoffTrajectory {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Balance won't be fully paid off in this setup.", systemImage: "exclamationmark.triangle.fill")
                        .font(.system(.subheadline, design: .rounded).weight(.bold))
                        .foregroundStyle(ClarityTheme.accentCoral)

                    Text("Estimated monthly interest now: \(Formatter.currency.string(from: NSNumber(value: viewModel.estimatedMonthlyInterest)) ?? "$0")")
                        .font(.system(.subheadline, design: .rounded))
                    Text("Estimated minimum payment now: \(Formatter.currency.string(from: NSNumber(value: viewModel.estimatedCurrentMinimumPayment)) ?? "$0")")
                        .font(.system(.subheadline, design: .rounded))
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(ClarityTheme.accentCoral.opacity(0.13))
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel("No full payoff warning. Balance does not fully pay off with current minimum payment settings.")
            }

            HStack(spacing: 10) {
                StatBlock(
                    title: "Total Interest",
                    value: Formatter.currency.string(from: NSNumber(value: viewModel.baseResult.totalInterest)) ?? "-"
                )
                StatBlock(
                    title: "Total Paid",
                    value: Formatter.currency.string(from: NSNumber(value: viewModel.baseResult.totalPaid)) ?? "-"
                )
            }

            if let warning = viewModel.warningText {
                Label(warning, systemImage: "exclamationmark.triangle.fill")
                    .font(.system(.subheadline, design: .rounded).weight(.semibold))
                    .foregroundStyle(ClarityTheme.accentWarm)
                    .accessibilityLabel("Warning: \(warning)")
            }
        }
    }

    private var inputsCard: some View {
        CardContainer {
            Text("Inputs")
                .font(ClarityTheme.titleFont)

            VStack(alignment: .leading, spacing: 10) {
                LabeledCurrencyField(label: "Balance", value: $viewModel.balance)

                LabeledPercentField(label: "APR (%)", value: $viewModel.apr)

                if viewModel.mode == .standard {
                    LabeledCurrencyField(label: "Monthly payment", value: $viewModel.payment)
                } else {
                    LabeledPercentField(label: "Minimum percent of balance", value: $viewModel.minPercent)
                    LabeledCurrencyField(label: "Minimum floor amount", value: $viewModel.floorAmount)
                }

                Toggle(isOn: $viewModel.includeCompounding) {
                    Text("Include monthly compounding (APR / 12)")
                        .font(.system(.subheadline, design: .rounded).weight(.semibold))
                }
                .accessibilityLabel("Include monthly compounding")
            }
        }
    }

    private var sliderCard: some View {
        CardContainer {
            Text("Try one change")
                .font(ClarityTheme.titleFont)

            Text("Add \(Formatter.currency.string(from: NSNumber(value: viewModel.extraPayment)) ?? "$0") each month")
                .font(.system(.headline, design: .rounded))

            Slider(value: $viewModel.extraPayment, in: 0...150, step: 5)
                .tint(ClarityTheme.accentCool)
                .accessibilityLabel("Extra monthly payment")

            HStack(spacing: 10) {
                StatBlock(
                    title: "New Interest",
                    value: Formatter.currency.string(from: NSNumber(value: viewModel.sliderResult.totalInterest)) ?? "-"
                )
                StatBlock(
                    title: "New Months",
                    value: viewModel.sliderResult.monthsToPayoff.map(String.init) ?? ">600"
                )
            }
        }
    }

    private var nextStepsCard: some View {
        CardContainer {
            Text(viewModel.mode == .standard ? "Next Step" : "Minimum-Payment Insight")
                .font(ClarityTheme.titleFont)
            if viewModel.mode == .standard {
                Text("1. Choose one extra payment amount you can sustain.")
                    .font(.system(.subheadline, design: .rounded))
                Text("2. Put a reminder on your due date and review each month.")
                    .font(.system(.subheadline, design: .rounded))
            } else {
                Text("1. This mode follows issuer-style minimum rules, which can stretch payoff time.")
                    .font(.system(.subheadline, design: .rounded))
                Text("2. Use Payoff Studio to test a fixed payment plan that is higher than minimum.")
                    .font(.system(.subheadline, design: .rounded))
            }
        }
    }

    private var assumptionsCard: some View {
        CardContainer {
            DisclosureGroup("Assumptions") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("- Interest uses APR/12 as a monthly rate.")
                    Text("- Estimates ignore penalties and issuer-specific rules.")
                    Text("- Calculations stop at 600 months (50 years).")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 6)
            }
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
            .accessibilityLabel("Assumptions")
        }
    }
}
