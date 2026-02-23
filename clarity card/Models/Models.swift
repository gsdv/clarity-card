import Foundation

enum ScenarioType: String, CaseIterable, Identifiable {
    case carryingBalance
    case minimumOnly
    case choosingCard
    case glossary
    case knowledgeCheck

    var id: String { rawValue }

    var title: String {
        switch self {
          case .carryingBalance: return "I'm carrying a balance"
          case .minimumOnly: return "I only pay the minimum"
          case .choosingCard: return "I'm choosing a card"
          case .glossary: return "I want to learn card terms"
          case .knowledgeCheck: return "I want to test my knowledge"
        }
    }

    var subtitle: String {
        switch self {
        case .carryingBalance:
            return "Estimate payoff time and interest, then test paying a little more"
        case .minimumOnly:
            return "See how minimum-payment formulas can stretch debt over years"
        case .choosingCard:
            return "Explore common card types and the tradeoffs between them"
        case .glossary:
            return "Search and review plain-language definitions of key credit terms"
        case .knowledgeCheck:
            return "Take a focused credit-card quiz and review results after final submit"
        }
    }

    var icon: String {
        switch self {
          case .carryingBalance: return "chart.line.uptrend.xyaxis"
          case .minimumOnly: return "hourglass"
          case .choosingCard: return "rectangle.stack.person.crop"
          case .glossary: return "text.book.closed"
          case .knowledgeCheck: return "brain.head.profile"
        }
    }
}

struct CreditTerm: Identifiable, Hashable {
    let section: String
    let term: String
    let plainDefinition: String
    let whyItMatters: String
    let example: String

    var id: String { term }
}

struct CardOffer: Identifiable, Hashable {
    let name: String
    let apr: Double
    let introAprPercent: Double
    let introMonths: Int
    let balanceTransferFeePercent: Double
    let balanceTransferMinFee: Double
    let annualFee: Double
    let gracePeriod: Bool
    let notes: String

    var id: String { name }
}

struct CardTypeProfile: Identifiable, Hashable {
    let name: String
    let icon: String
    let popularity: String
    let bestFor: String
    let typicalAprRange: String
    let annualFeeRange: String
    let strengths: [String]
    let tradeoffs: [String]
    let watchFor: String

    var id: String { name }
}

struct PayoffInput: Hashable {
    let balance: Double
    let apr: Double
    let monthlyPayment: Double
    let includeCompounding: Bool
    let maxMonths: Int
}

struct PayoffResult: Hashable {
    let monthsToPayoff: Int?
    let totalInterest: Double
    let totalPaid: Double
    let negativeAmortizationRisk: Bool
    let reachedMaxMonths: Bool
}

struct ComparisonScenario: Identifiable {
    let label: String
    let payment: Double
    let result: PayoffResult

    var id: String { label }
}

struct QuizQuestion: Identifiable {
    let prompt: String
    let options: [String]
    let answerIndex: Int
    let explanation: String

    var id: String { prompt }
}

struct ScenarioCard: Identifiable {
    let type: ScenarioType

    var id: String { type.id }
    var title: String { type.title }
    var subtitle: String { type.subtitle }
    var icon: String { type.icon }
}
