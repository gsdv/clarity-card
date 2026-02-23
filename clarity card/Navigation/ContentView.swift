import SwiftUI

enum AppRoute: Hashable {
    case payoffStandard
    case payoffMinimum
    case choosingCard
    case glossary
    case knowledgeQuiz
    case about
}

struct ContentView: View {
    @State private var hasStarted = false
    @State private var path: [AppRoute] = []

    var body: some View {
        Group {
            if hasStarted {
                NavigationStack(path: $path) {
                    ScenarioPickerView { selected in
                        switch selected {
                        case .carryingBalance: path.append(.payoffStandard)
                        case .minimumOnly: path.append(.payoffMinimum)
                        case .choosingCard: path.append(.choosingCard)
                        case .glossary: path.append(.glossary)
                        case .knowledgeCheck: path.append(.knowledgeQuiz)
                        }
                    }
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .payoffStandard:
                            PayoffSimulatorView(mode: .standard)
                        case .payoffMinimum:
                            PayoffSimulatorView(mode: .minimum)
                        case .choosingCard:
                            ChoosingCardView()
                        case .glossary:
                            GlossaryView()
                        case .knowledgeQuiz:
                            KnowledgeQuizView()
                        case .about:
                            AboutView()
                        }
                    }
                }
                .transition(.opacity)
            } else {
                WelcomeView {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        hasStarted = true
                        path.removeAll()
                    }
                }
                .transition(.opacity)
            }
        }
        .tint(ClarityTheme.accentCool)
    }
}
