import Foundation

enum PayoffCalculator {
    static func simulateFixedPayment(input: PayoffInput) -> PayoffResult {
        let monthlyRate = max(0, input.apr) / 12.0 / 100.0
        var balance = max(0, input.balance)
        var month = 0
        var totalInterest = 0.0
        var negativeAmortization = false

        while balance > 0.0001 && month < input.maxMonths {
            let interest = balance * monthlyRate
            if input.monthlyPayment <= interest {
                negativeAmortization = true
            }

            totalInterest += interest

            if input.includeCompounding {
                balance += interest
                let paymentApplied = min(input.monthlyPayment, balance)
                balance -= paymentApplied
            } else {
                let principalReduction = max(0, input.monthlyPayment - interest)
                let paymentApplied = min(input.monthlyPayment, balance + interest)
                if paymentApplied < interest {
                    negativeAmortization = true
                }
                balance -= principalReduction
            }

            month += 1
        }

        let paidOff = balance <= 0.0001
        let months = paidOff ? month : nil
        let totalPaid = input.balance + totalInterest

        return PayoffResult(
            monthsToPayoff: months,
            totalInterest: totalInterest,
            totalPaid: totalPaid,
            negativeAmortizationRisk: negativeAmortization,
            reachedMaxMonths: !paidOff
        )
    }

    static func simulateMinimumPayment(
        balance initialBalance: Double,
        apr: Double,
        minPercent: Double,
        floorAmount: Double,
        extraPayment: Double = 0,
        includeCompounding: Bool,
        maxMonths: Int = 600
    ) -> PayoffResult {
        let monthlyRate = max(0, apr) / 12.0 / 100.0
        var balance = max(0, initialBalance)
        var month = 0
        var totalInterest = 0.0
        var negativeAmortization = false

        while balance > 0.0001 && month < maxMonths {
            let payment = max(floorAmount, (minPercent / 100.0) * balance) + max(0, extraPayment)
            let interest = balance * monthlyRate

            if payment <= interest {
                negativeAmortization = true
            }

            totalInterest += interest

            if includeCompounding {
                balance += interest
                let paymentApplied = min(payment, balance)
                balance -= paymentApplied
            } else {
                let principalReduction = max(0, payment - interest)
                let paymentApplied = min(payment, balance + interest)
                if paymentApplied < interest {
                    negativeAmortization = true
                }
                balance -= principalReduction
            }

            month += 1
        }

        let paidOff = balance <= 0.0001
        let months = paidOff ? month : nil
        let totalPaid = initialBalance + totalInterest

        return PayoffResult(
            monthsToPayoff: months,
            totalInterest: totalInterest,
            totalPaid: totalPaid,
            negativeAmortizationRisk: negativeAmortization,
            reachedMaxMonths: !paidOff
        )
    }
}
