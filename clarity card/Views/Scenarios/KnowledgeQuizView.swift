import SwiftUI

struct KnowledgeQuizView: View {
    @StateObject private var viewModel = CreditQuizViewModel()

    var body: some View {
        ScreenContainer {
            Text("Knowledge Check")
                .font(.system(.largeTitle, design: .rounded).weight(.black))

            Text( "Answer all questions, then submit once to reveal your full results.")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)

            if viewModel.hasSubmitted {
                CardContainer {
                    Text("Score: \(viewModel.score)/\(viewModel.questions.count)")
                        .font(.system(.title3, design: .rounded).weight(.bold))
                    Text(viewModel.scoreMessage)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)

                    Button("Retake Quiz") {
                        viewModel.reset()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(ClarityTheme.accentWarm)
                }
            }

            ForEach(Array(viewModel.questions.enumerated()), id: \.element.id) { index, question in
                quizQuestionCard(index: index, question: question)
            }

            CardContainer {
                if !viewModel.canSubmit, !viewModel.hasSubmitted {
                    Text("Answer \(viewModel.unansweredCount) more question(s) to submit.")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                }

                Button("Final Submit") {
                    viewModel.submit()
                }
                .buttonStyle(PrimaryGlowButtonStyle())
                .disabled(!viewModel.canSubmit || viewModel.hasSubmitted)
                .opacity((!viewModel.canSubmit || viewModel.hasSubmitted) ? 0.45 : 1)
                .accessibilityLabel("Submit quiz")
            }
        }
        .navigationTitle("Knowledge Quiz")
    }

    @ViewBuilder
    private func quizQuestionCard(index: Int, question: QuizQuestion) -> some View {
        CardContainer {
            Text("\(index + 1). \(question.prompt)")
                .font(.system(.subheadline, design: .rounded).weight(.semibold))

            ForEach(Array(question.options.enumerated()), id: \.offset) { optionIndex, option in
                Button {
                    guard !viewModel.hasSubmitted else { return }
                    viewModel.selectAnswer(for: question, index: optionIndex)
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: viewModel.answers[question.id] == optionIndex ? "largecircle.fill.circle" : "circle")
                            .foregroundStyle(viewModel.answers[question.id] == optionIndex ? ClarityTheme.accentCool : .secondary)
                        Text(option)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white.opacity(0.3))
                    )
                }
                .buttonStyle(.plain)
                .disabled(viewModel.hasSubmitted)
                .accessibilityLabel("Answer option \(option)")
            }

            if viewModel.hasSubmitted {
                let isCorrect = viewModel.answers[question.id] == question.answerIndex
                Text(isCorrect ? "Correct" : "Incorrect")
                    .font(.system(.subheadline, design: .rounded).weight(.bold))
                    .foregroundStyle(isCorrect ? ClarityTheme.accentCool : ClarityTheme.accentCoral)
                Text("Correct answer: \(question.options[question.answerIndex])")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(question.explanation)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
