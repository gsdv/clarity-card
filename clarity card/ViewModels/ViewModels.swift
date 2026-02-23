import Foundation
import Combine
import SwiftUI

final class ScenarioViewModel: ObservableObject {
    let scenarios = ScenarioType.allCases.map(ScenarioCard.init)
}

private struct SimulationKey: Hashable {
    let mode: String
    let balance: Int
    let apr: Int
    let payment: Int
    let minPercent: Int
    let floor: Int
    let includeCompounding: Bool

    init(mode: String, balance: Double, apr: Double, payment: Double, minPercent: Double, floor: Double, includeCompounding: Bool) {
        self.mode = mode
        self.balance = Int((balance * 100).rounded())
        self.apr = Int((apr * 100).rounded())
        self.payment = Int((payment * 100).rounded())
        self.minPercent = Int((minPercent * 100).rounded())
        self.floor = Int((floor * 100).rounded())
        self.includeCompounding = includeCompounding
    }
}

enum PayoffMode {
    case standard
    case minimum
}

final class PayoffViewModel: ObservableObject {
    @Published var balance: Double = 1900 { didSet { recalculate() } }
    @Published var apr: Double = 24.99 { didSet { recalculate() } }
    @Published var payment: Double = 60 { didSet { recalculate() } }
    @Published var extraPayment: Double = 25 { didSet { recalculate() } }
    @Published var includeCompounding = true { didSet { recalculate() } }

    @Published var minPercent: Double = 2 { didSet { recalculate() } }
    @Published var floorAmount: Double = 25 { didSet { recalculate() } }

    @Published private(set) var baseResult = PayoffResult(monthsToPayoff: nil, totalInterest: 0, totalPaid: 0, negativeAmortizationRisk: false, reachedMaxMonths: false)
    @Published private(set) var plus25Result = PayoffResult(monthsToPayoff: nil, totalInterest: 0, totalPaid: 0, negativeAmortizationRisk: false, reachedMaxMonths: false)
    @Published private(set) var plus50Result = PayoffResult(monthsToPayoff: nil, totalInterest: 0, totalPaid: 0, negativeAmortizationRisk: false, reachedMaxMonths: false)
    @Published private(set) var sliderResult = PayoffResult(monthsToPayoff: nil, totalInterest: 0, totalPaid: 0, negativeAmortizationRisk: false, reachedMaxMonths: false)

    let mode: PayoffMode
    private var cache: [SimulationKey: PayoffResult] = [:]

    init(mode: PayoffMode) {
        self.mode = mode
        recalculate()
    }

    var comparisonScenarios: [ComparisonScenario] {
        let basePayment = mode == .minimum ? estimatedCurrentMinimumPayment : payment
        guard mode == .standard else {
            return [
                ComparisonScenario(label: "Current minimum", payment: basePayment, result: baseResult)
            ]
        }

        return [
            ComparisonScenario(label: "Current", payment: basePayment, result: baseResult),
            ComparisonScenario(label: "+$25", payment: basePayment + 25, result: plus25Result),
            ComparisonScenario(label: "+$50", payment: basePayment + 50, result: plus50Result),
            ComparisonScenario(label: "Your extra", payment: basePayment + extraPayment, result: sliderResult)
        ]
    }

    var estimatedCurrentMinimumPayment: Double {
        max(floorAmount, (minPercent / 100) * balance)
    }

    var estimatedMonthlyInterest: Double {
        max(0, balance) * (max(0, apr) / 12.0 / 100.0)
    }

    var noPayoffTrajectory: Bool {
        mode == .minimum && baseResult.monthsToPayoff == nil
    }

    var payoffHeadline: String {
        if noPayoffTrajectory {
            return "No full payoff trajectory"
        }

        if let months = baseResult.monthsToPayoff {
            return "Estimated payoff: \(months) months"
        }
        return "Payoff exceeds \(maxMonths) months"
    }

    var coachingText: String {
        if mode == .minimum {
            let percentString = Formatter.percent.string(from: NSNumber(value: minPercent)) ?? "\(minPercent)"
            let floorString = Formatter.currency.string(from: NSNumber(value: floorAmount)) ?? "$0"
            let currentMinimum = Formatter.currency.string(from: NSNumber(value: estimatedCurrentMinimumPayment)) ?? "$0"
            return "This mode recalculates payment each month as max (\(percentString)% of balance, \(floorString)). Current minimum is about \(currentMinimum)."
        }

        guard let baseMonths = baseResult.monthsToPayoff,
              let sliderMonths = sliderResult.monthsToPayoff else {
            let savings = baseResult.totalInterest - sliderResult.totalInterest
            return "Adding \(Formatter.currency.string(from: NSNumber(value: extraPayment)) ?? "$0") could lower interest by \(Formatter.currency.string(from: NSNumber(value: max(0, savings))) ?? "$0")."
        }

        let monthsSaved = max(0, baseMonths - sliderMonths)
        let interestSaved = max(0, baseResult.totalInterest - sliderResult.totalInterest)
        let monthLabel = monthsSaved == 1 ? "month" : "months"
        return "If you pay \(Formatter.currency.string(from: NSNumber(value: extraPayment)) ?? "$0") more, you save \(Formatter.currency.string(from: NSNumber(value: interestSaved)) ?? "$0") and finish \(monthsSaved) \(monthLabel) earlier."
    }

    var warningText: String? {
        if noPayoffTrajectory {
            if baseResult.negativeAmortizationRisk {
                return "Your minimum payment can be below monthly interest. Balance may grow instead of shrinking."
            }
            return "At this minimum setting, balance is not paid off within 50 years. Treat this as an effective never-payoff path."
        }

        if baseResult.negativeAmortizationRisk {
            return "Payment may be too low to reduce your balance (negative amortization risk)."
        }

        if mode == .minimum, let months = baseResult.monthsToPayoff, months > 120 {
            return "At this pace, payoff could take over 10 years."
        }

        return nil
    }

    var maxMonths: Int { 600 }

    private func recalculate() {
        switch mode {
        case .standard:
            baseResult = simulateStandard(withPayment: payment)
            plus25Result = simulateStandard(withPayment: payment + 25)
            plus50Result = simulateStandard(withPayment: payment + 50)
            sliderResult = simulateStandard(withPayment: payment + extraPayment)
        case .minimum:
            baseResult = simulateMinimum(extra: 0)
            plus25Result = baseResult
            plus50Result = baseResult
            sliderResult = baseResult
        }
    }

    private func simulateStandard(withPayment monthlyPayment: Double) -> PayoffResult {
        let p = max(1, monthlyPayment)
        let key = SimulationKey(
            mode: "standard",
            balance: balance,
            apr: apr,
            payment: p,
            minPercent: 0,
            floor: 0,
            includeCompounding: includeCompounding
        )

        if let cached = cache[key] {
            return cached
        }

        let input = PayoffInput(
            balance: balance,
            apr: apr,
            monthlyPayment: p,
            includeCompounding: includeCompounding,
            maxMonths: maxMonths
        )
        let result = PayoffCalculator.simulateFixedPayment(input: input)
        cache[key] = result
        return result
    }

    private func simulateMinimum(extra: Double) -> PayoffResult {
        let key = SimulationKey(
            mode: "minimum",
            balance: balance,
            apr: apr,
            payment: extra,
            minPercent: minPercent,
            floor: floorAmount,
            includeCompounding: includeCompounding
        )

        if let cached = cache[key] {
            return cached
        }

        let result = PayoffCalculator.simulateMinimumPayment(
            balance: balance,
            apr: apr,
            minPercent: minPercent,
            floorAmount: floorAmount,
            extraPayment: extra,
            includeCompounding: includeCompounding,
            maxMonths: maxMonths
        )
        cache[key] = result
        return result
    }
}

final class ChoosingCardViewModel: ObservableObject {
    @Published var selectedProfile: CardTypeProfile? = LocalDataStore.cardTypeProfiles.first

    let profiles = LocalDataStore.cardTypeProfiles
}

final class CreditQuizViewModel: ObservableObject {
    @Published var answers: [String: Int] = [:]
    @Published var hasSubmitted = false
    @Published private(set) var questions: [QuizQuestion]

    init() {
        questions = Self.shuffledQuestions(from: LocalDataStore.quizQuestions)
    }

    var score: Int {
        questions.reduce(0) { partial, question in
            partial + ((answers[question.id] == question.answerIndex) ? 1 : 0)
        }
    }

    var scoreMessage: String {
        let total = questions.count
        guard total > 0 else { return "" }
        let ratio = Double(score) / Double(total)

        if ratio >= 0.9 { return "Excellent. You have strong credit-card cost awareness." }
        if ratio >= 0.7 { return "Great work. You understand most of the important concepts." }
        if ratio >= 0.5 { return "Solid start. Review APR, fees, and minimum-payment effects." }
        return "Good effort. Revisit term definitions, then retake the quiz."
    }

    var unansweredCount: Int {
        max(0, questions.count - answers.count)
    }

    var canSubmit: Bool {
        answers.count == questions.count && !questions.isEmpty
    }

    func selectAnswer(for question: QuizQuestion, index: Int) {
        answers[question.id] = index
    }

    func submit() {
        hasSubmitted = true
    }

    func reset() {
        answers.removeAll()
        hasSubmitted = false
        questions = Self.shuffledQuestions(from: LocalDataStore.quizQuestions)
    }

    private static func shuffledQuestions(from source: [QuizQuestion]) -> [QuizQuestion] {
        source.map { question in
            let indexedOptions = Array(question.options.enumerated())
            let shuffled = indexedOptions.shuffled()

            guard let newAnswerIndex = shuffled.firstIndex(where: { $0.offset == question.answerIndex }) else {
                return question
            }

            return QuizQuestion(
                prompt: question.prompt,
                options: shuffled.map(\.element),
                answerIndex: newAnswerIndex,
                explanation: question.explanation
            )
        }
    }
}

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    static let percent: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
