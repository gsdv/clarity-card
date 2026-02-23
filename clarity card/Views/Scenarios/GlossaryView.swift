import SwiftUI

struct GlossaryView: View {
    @State private var searchText = ""
    private let allTerms = LocalDataStore.creditTerms

    var body: some View {
        ScreenContainer {
            Text("Glossary")
                .font(.system(.largeTitle, design: .rounded).weight(.black))

            Text("Search a term and read a plain-language definition.")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)

            CardContainer {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search terms (APR, grace period, annual fee...)", text: $searchText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Clear search")
                    }
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(uiColor: .systemBackground).opacity(0.95))
                )
            }

            if filteredTerms.isEmpty {
                CardContainer {
                    Text("No terms found")
                        .font(ClarityTheme.titleFont)
                    Text("Try a different keyword.")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            } else {
                if isSearching {
                    ForEach(filteredTerms) { term in
                        termCard(term)
                    }
                } else {
                    ForEach(sectionedTerms, id: \.section) { section in
                        Text(section.section)
                            .font(.system(.title3, design: .rounded).weight(.bold))
                            .padding(.horizontal, 4)

                        ForEach(section.terms) { term in
                            termCard(term)
                        }
                    }
                }
            }
        }
        .navigationTitle("Glossary")
    }

    private var isSearching: Bool {
        !query.isEmpty
    }

    private var query: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var filteredTerms: [CreditTerm] {
        guard !isSearching else {
            return allTerms.filter { term in
                term.term.localizedCaseInsensitiveContains(query)
                    || term.plainDefinition.localizedCaseInsensitiveContains(query)
                    || term.whyItMatters.localizedCaseInsensitiveContains(query)
                    || term.example.localizedCaseInsensitiveContains(query)
                    || term.section.localizedCaseInsensitiveContains(query)
            }
            .sorted { $0.term < $1.term }
        }

        return allTerms.sorted { $0.term < $1.term }
    }

    private var sectionedTerms: [(section: String, terms: [CreditTerm])] {
        let sectionOrder = allTerms.map(\.section).reduce(into: [String]()) { partial, section in
            if !partial.contains(section) {
                partial.append(section)
            }
        }

        return sectionOrder.compactMap { section in
            let terms = allTerms
                .filter { $0.section == section }
                .sorted { $0.term < $1.term }
            guard !terms.isEmpty else {
                return nil
            }
            return (section, terms)
        }
    }

    @ViewBuilder
    private func termCard(_ term: CreditTerm) -> some View {
        CardContainer {
            Text(term.term)
                .font(ClarityTheme.titleFont)
            Text(term.plainDefinition)
                .font(.system(.body, design: .rounded))
            Text("Why it matters: \(term.whyItMatters)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Example: \(term.example)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
