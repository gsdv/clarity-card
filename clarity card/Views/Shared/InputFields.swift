import SwiftUI

private struct InputShell<Content: View>: View {
    let label: String
    let icon: String
    let content: Content

    init(label: String, icon: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(label, systemImage: icon)
                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                .foregroundStyle(.primary)
            content
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.white.opacity(0.35))
        )
    }
}

struct LabeledCurrencyField: View {
    let label: String
    @Binding var value: Double

    var body: some View {
        InputShell(label: label, icon: "dollarsign.circle") {
            TextField(label, value: $value, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
                .textFieldStyle(.plain)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(uiColor: .systemBackground).opacity(0.95))
                )
                .accessibilityLabel(label)
        }
    }
}

struct LabeledPercentField: View {
    let label: String
    @Binding var value: Double

    var body: some View {
        InputShell(label: label, icon: "percent") {
            TextField(label, value: $value, format: .number.precision(.fractionLength(0...2)))
                .keyboardType(.decimalPad)
                .textFieldStyle(.plain)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(uiColor: .systemBackground).opacity(0.95))
                )
                .accessibilityLabel(label)
        }
    }
}
