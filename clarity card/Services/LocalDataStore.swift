import Foundation

enum LocalDataStore {
    static let creditTerms: [CreditTerm] = [
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "APR",
            plainDefinition: "APR is the yearly interest rate charged on balances you carry.",
            whyItMatters: "Higher APR usually means more interest paid over time.",
            example: "A 24.99% APR balance usually grows faster than one at 15%."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Intro APR",
            plainDefinition: "An intro APR is a temporary lower rate, often 0%, for a set number of months.",
            whyItMatters: "Once it ends, the regular APR applies to remaining balances.",
            example: "0% for 12 months can help if you pay down debt before month 13."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Purchase APR",
            plainDefinition: "Interest rate applied to purchases when you carry a balance.",
            whyItMatters: "It is usually the biggest driver of long-term borrowing cost.",
            example: "Carrying a $1,000 purchase balance at a high purchase APR costs more interest each month."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Penalty APR",
            plainDefinition: "Higher APR that may apply after late or returned payments.",
            whyItMatters: "A penalty rate can sharply increase your interest cost.",
            example: "Missing payments can move an account from a normal APR to a much higher penalty APR."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Variable APR",
            plainDefinition: "APR that can move up or down over time, often tied to a benchmark index.",
            whyItMatters: "Your borrowing cost can change even if your balance behavior stays the same.",
            example: "If benchmark rates rise, a variable APR card can become more expensive."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Daily periodic rate (DPR)",
            plainDefinition: "The daily interest rate used to compute finance charges.",
            whyItMatters: "Interest is often calculated daily, not just once at month end.",
            example: "A higher DPR means each day of carried balance adds more interest."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Average daily balance",
            plainDefinition: "Common method issuers use to calculate interest during a billing cycle.",
            whyItMatters: "Higher balances held longer during the cycle usually mean higher interest.",
            example: "Paying part of your balance earlier in the cycle can lower your average daily balance."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Statement balance",
            plainDefinition: "Total balance shown when a billing cycle closes.",
            whyItMatters: "Paying this in full by the due date usually avoids purchase interest.",
            example: "If your statement balance is $420 and you pay all $420 by due date, purchase interest is often avoided."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Current balance",
            plainDefinition: "Real-time account balance including posted transactions and sometimes pending activity.",
            whyItMatters: "It helps you track live spending and available credit, but it is not always the amount due now.",
            example: "Your current balance can be higher than your statement balance after new purchases."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Grace period",
            plainDefinition: "A grace period is time to pay your statement balance without purchase interest.",
            whyItMatters: "If you carry a balance, many cards stop giving full grace on new purchases.",
            example: "Paying in full by the due date can avoid purchase interest."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Minimum payment",
            plainDefinition: "The minimum payment is the smallest amount required to keep the account current.",
            whyItMatters: "Paying only minimums can lead to long payoff times and high interest costs.",
            example: "A $25 minimum may barely reduce a large high-APR balance."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Paying in full",
            plainDefinition: "Paying the full statement balance by the due date.",
            whyItMatters: "It is one of the best ways to avoid purchase interest.",
            example: "A full on-time statement payment can keep interest on purchases at $0."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Autopay",
            plainDefinition: "Automatic payment setup for minimum due, statement balance, or a fixed amount.",
            whyItMatters: "It reduces missed-payment risk and helps keep payment behavior consistent.",
            example: "Setting autopay for statement balance helps avoid accidental late payments."
        ),
        CreditTerm(
            section: "Rates, interest, and payments",
            term: "Returned payment",
            plainDefinition: "A payment that fails, such as from insufficient funds.",
            whyItMatters: "It can trigger fees and may contribute to APR penalties.",
            example: "A failed bank draft can cause a returned-payment fee and account warnings."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Cash back",
            plainDefinition: "Rewards paid as statement credit, deposit, or check, usually as a percent of purchases.",
            whyItMatters: "Simple redemption makes value easier to track.",
            example: "A 2% cash back card earns $2 for each $100 spent."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Points / miles",
            plainDefinition: "Reward currencies redeemed for travel, gift cards, statement credits, or partner transfers.",
            whyItMatters: "Value can vary a lot by redemption method.",
            example: "10,000 points may be worth more on travel redemptions than as a statement credit."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Redemption value",
            plainDefinition: "What your points are worth based on how you redeem them.",
            whyItMatters: "Different redemption paths can change your real return significantly.",
            example: "The same points can yield different value for travel, cash, or gift cards."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Transfer partners",
            plainDefinition: "Airline or hotel programs you can transfer points to.",
            whyItMatters: "Transfers can increase value but require careful timing and availability.",
            example: "Moving points to a partner airline can unlock better flight value than direct cash redemption."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Category bonus",
            plainDefinition: "Higher earn rate in specific spending categories like dining or gas.",
            whyItMatters: "Category fit determines whether a rewards card actually performs well for you.",
            example: "A 3x dining bonus matters most if you spend heavily on restaurants."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Rotating categories",
            plainDefinition: "Bonus categories that change monthly or quarterly and may require activation.",
            whyItMatters: "Missing activation can reduce expected rewards.",
            example: "If grocery stores are a bonus category this quarter, activation may be required to earn the higher rate."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Spending cap",
            plainDefinition: "Maximum spend amount that earns a bonus rate before rewards drop to a lower rate.",
            whyItMatters: "Caps can limit total value from bonus categories.",
            example: "A card may offer bonus rewards up to $1,500 per quarter, then revert to base earnings."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Minimum spend requirement",
            plainDefinition: "Amount you must spend in a set period to earn a welcome bonus.",
            whyItMatters: "Overspending to chase a bonus can erase its value.",
            example: "A bonus might require $3,000 in purchases within 3 months."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Welcome bonus",
            plainDefinition: "One-time reward earned after meeting a minimum spend requirement.",
            whyItMatters: "It can be valuable, but only if the spend target fits your budget.",
            example: "Earning a welcome bonus can offset fees if spending was already planned."
        ),
        CreditTerm(
            section: "Rewards and points",
            term: "Breakage / points expiration",
            plainDefinition: "Losing points because they expire or an account is closed.",
            whyItMatters: "Unredeemed points can become zero value.",
            example: "Closing a card before moving points can forfeit remaining rewards."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Late fee",
            plainDefinition: "Fee charged when payment is made after the due date.",
            whyItMatters: "Late fees increase cost and repeated lateness can trigger other penalties.",
            example: "Paying one day late may still result in a late fee depending on issuer policy."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Foreign transaction fee",
            plainDefinition: "Fee, often around 1%-3%, for purchases processed outside your home country or currency.",
            whyItMatters: "Travel or foreign online purchases can become more expensive than expected.",
            example: "A 3% fee adds $30 to a $1,000 international purchase."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Balance transfer",
            plainDefinition: "Moving debt from one credit card to another, often for a lower intro APR.",
            whyItMatters: "It may reduce interest, but fees and promo end dates still matter.",
            example: "Transferring a high-APR balance to a 0% intro card can lower short-term interest cost."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Balance transfer fee",
            plainDefinition: "A balance transfer fee is a one-time percentage charged when moving debt to a new card.",
            whyItMatters: "A low intro APR can still be expensive if transfer fees are high.",
            example: "A 3% fee on $2,000 is $60 added right away."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Cash advance",
            plainDefinition: "Withdrawing cash using a credit card instead of a bank account.",
            whyItMatters: "Cash advances often have immediate interest and extra fees.",
            example: "Using a card at an ATM can trigger a cash advance fee plus high APR."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Annual fee",
            plainDefinition: "An annual fee is a fixed amount charged each year for having the card.",
            whyItMatters: "It raises your total cost, especially if rewards do not offset it.",
            example: "A $95 annual fee adds $95 even if you never carry a balance."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Cash advance APR",
            plainDefinition: "Cash advance APR is the interest rate for cash withdrawals on your credit card.",
            whyItMatters: "It is often higher and may start accruing interest immediately.",
            example: "A cash advance can trigger both a fee and high interest from day one."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Cash advance fee",
            plainDefinition: "Flat amount or percentage charged when you take a cash advance.",
            whyItMatters: "This fee is added immediately, before interest is even counted.",
            example: "A 5% cash advance fee on $300 adds $15 instantly."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Over-the-limit fee",
            plainDefinition: "Fee for exceeding your credit limit, now less common and often opt-in.",
            whyItMatters: "It can add avoidable cost on top of high utilization risk.",
            example: "Going over limit may trigger a fee if your account is configured for over-limit transactions."
        ),
        CreditTerm(
            section: "Fees and gotchas",
            term: "Deferred interest",
            plainDefinition: "\"No interest if paid in full by X date\" offer where missed payoff can trigger retroactive interest.",
            whyItMatters: "If not fully paid by deadline, past interest can be charged all at once.",
            example: "Store financing may add months of back interest if even a small balance remains at promo end."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Credit limit",
            plainDefinition: "Maximum amount you can borrow on a card at one time.",
            whyItMatters: "It sets spending headroom and affects utilization.",
            example: "With a $2,000 limit, a $1,000 balance equals 50% utilization."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Available credit",
            plainDefinition: "Remaining credit limit after subtracting current balance.",
            whyItMatters: "Lower available credit can raise utilization and reduce flexibility.",
            example: "A $5,000 limit with a $1,500 balance leaves $3,500 available."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Utilization (credit utilization ratio)",
            plainDefinition: "How much of your available credit you are using.",
            whyItMatters: "High utilization can pressure credit scores.",
            example: "Using $900 on a $1,000 limit is 90% utilization."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Credit line increase (CLI)",
            plainDefinition: "An issuer increase to your credit limit, sometimes by request.",
            whyItMatters: "A higher limit can lower utilization if spending stays steady.",
            example: "Moving from a $2,000 to $4,000 limit cuts utilization in half at the same balance."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Hard inquiry",
            plainDefinition: "Credit check that may temporarily affect your score, commonly from applications.",
            whyItMatters: "Too many hard pulls in a short time can reduce approval odds.",
            example: "Submitting multiple new card applications quickly can add several hard inquiries."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Soft inquiry",
            plainDefinition: "Credit check that does not affect your score, such as pre-approval checks.",
            whyItMatters: "You can monitor eligibility without direct scoring impact.",
            example: "A prequalified offer usually uses a soft inquiry."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Age of accounts",
            plainDefinition: "How long your credit accounts have been open.",
            whyItMatters: "Longer average account age is generally better for credit profile stability.",
            example: "Keeping an older no-fee card open can help average account age."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Derogatory mark",
            plainDefinition: "Serious negative item on a credit report, such as major delinquency.",
            whyItMatters: "It can significantly harm credit scores and approval outcomes.",
            example: "A severe late history entry can remain visible for years."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Delinquency",
            plainDefinition: "Late payment status reported to bureaus, often once 30+ days past due.",
            whyItMatters: "Reported delinquencies can damage your credit profile.",
            example: "Paying 35 days late may result in a 30-day delinquency mark."
        ),
        CreditTerm(
            section: "Credit limits, utilization, and credit scores",
            term: "Collections",
            plainDefinition: "Debt transferred or sold to a collection agency after severe nonpayment.",
            whyItMatters: "Collections are serious negative events for credit health.",
            example: "Unresolved card debt can eventually be moved to collections."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Billing cycle",
            plainDefinition: "Date range where transactions are grouped into one statement.",
            whyItMatters: "Cycle timing affects statement balance, due date, and interest calculations.",
            example: "Purchases just before cycle close may appear on the next statement quickly."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Due date",
            plainDefinition: "Date payment must be received to be considered on time.",
            whyItMatters: "Missing due date can trigger late fees and credit damage.",
            example: "Scheduling payment one or two days early helps avoid processing surprises."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Posting date vs. transaction date",
            plainDefinition: "Transaction date is when purchase happened; posting date is when it is officially recorded.",
            whyItMatters: "Timing differences can affect statement totals and available credit.",
            example: "A weekend purchase may post days later with a different posting date."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Pending transaction",
            plainDefinition: "Authorized charge that has not fully posted yet.",
            whyItMatters: "Pending amounts can temporarily reduce available credit.",
            example: "A restaurant hold may update after final tip is processed."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Authorization hold",
            plainDefinition: "Temporary amount reserved by a merchant before final charge settles.",
            whyItMatters: "Large holds can tie up credit even if final purchase is smaller.",
            example: "Hotels and gas stations often place holds above the final amount."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Dispute / chargeback",
            plainDefinition: "Process to challenge a charge due to issues like fraud or item not received.",
            whyItMatters: "It can help recover funds from invalid or unauthorized transactions.",
            example: "If a merchant never delivers an order, you may file a dispute."
        ),
        CreditTerm(
            section: "Using the card day-to-day",
            term: "Fraud liability",
            plainDefinition: "Rules and protections that limit what you owe for unauthorized charges.",
            whyItMatters: "Protection levels vary by issuer policy and reporting speed.",
            example: "Promptly reporting stolen-card charges can reduce your liability."
        ),
        CreditTerm(
            section: "Strategies and advanced concepts",
            term: "Card churning",
            plainDefinition: "Opening cards mainly for welcome bonuses, then often downgrading or closing later.",
            whyItMatters: "It requires strict tracking and can affect approvals or credit profile.",
            example: "Frequent bonus-chasing without planning may lead to too many new accounts."
        ),
        CreditTerm(
            section: "Strategies and advanced concepts",
            term: "Velocity",
            plainDefinition: "How many new accounts you open within a short period.",
            whyItMatters: "High velocity can reduce approval chances and trigger issuer caution.",
            example: "Applying for several cards in a few months can be viewed as high velocity."
        ),
        CreditTerm(
            section: "Strategies and advanced concepts",
            term: "Authorized user (AU)",
            plainDefinition: "Person added to an account who can spend but usually is not legally responsible for payment.",
            whyItMatters: "It can help establish history, but primary account behavior still controls outcomes.",
            example: "A parent can add a student as AU while retaining legal payment responsibility."
        ),
        CreditTerm(
            section: "Safety and healthy habits",
            term: "Budget buffer",
            plainDefinition: "Extra room in your budget so you can still pay statement balance despite surprises.",
            whyItMatters: "It lowers the chance of carrying debt from unexpected costs.",
            example: "Keeping a small monthly cushion can prevent relying on minimum payments."
        ),
        CreditTerm(
            section: "Safety and healthy habits",
            term: "Debt snowball / debt avalanche",
            plainDefinition: "Two payoff strategies: smallest balance first (snowball) or highest APR first (avalanche).",
            whyItMatters: "Choosing a clear strategy improves consistency and progress.",
            example: "Avalanche usually saves more interest, while snowball can improve motivation."
        )
    ]

    static let sampleOffers: [CardOffer] = [
        CardOffer(
            name: "Starter Calm Card",
            apr: 19.99,
            introAprPercent: 0,
            introMonths: 12,
            balanceTransferFeePercent: 3,
            balanceTransferMinFee: 5,
            annualFee: 0,
            gracePeriod: true,
            notes: "Good intro window, standard transfer fee."
        ),
        CardOffer(
            name: "Low Fee Everyday",
            apr: 17.49,
            introAprPercent: 0,
            introMonths: 6,
            balanceTransferFeePercent: 5,
            balanceTransferMinFee: 10,
            annualFee: 0,
            gracePeriod: true,
            notes: "Lower regular APR, shorter intro period."
        ),
        CardOffer(
            name: "Rewards Plus",
            apr: 25.99,
            introAprPercent: 0,
            introMonths: 15,
            balanceTransferFeePercent: 4,
            balanceTransferMinFee: 5,
            annualFee: 95,
            gracePeriod: true,
            notes: "Long intro period but high ongoing APR and annual fee."
        )
    ]

    static let cardTypeProfiles: [CardTypeProfile] = [
        CardTypeProfile(
            name: "Cash Back Card",
            icon: "banknote",
            popularity: "Very common",
            bestFor: "Everyday spending with simple rewards.",
            typicalAprRange: "18% - 29% variable",
            annualFeeRange: "$0 to $95",
            strengths: [
                "Simple value you can understand quickly",
                "Often has no annual fee options",
                "Good for routine expenses"
            ],
            tradeoffs: [
                "Rewards are smaller than premium travel cards",
                "High APR can erase rewards if you carry debt",
                "Rotating categories may require extra tracking"
            ],
            watchFor: "Compare base earn rate and any category caps."
        ),
        CardTypeProfile(
            name: "Travel Rewards Card",
            icon: "airplane",
            popularity: "Popular among frequent travelers",
            bestFor: "Frequent travel and point transfer flexibility.",
            typicalAprRange: "20% - 30% variable",
            annualFeeRange: "$95 to $550",
            strengths: [
                "Potentially high reward value on travel",
                "May include lounge, insurance, or partner perks",
                "Good transfer options on select cards"
            ],
            tradeoffs: [
                "Annual fees can be high",
                "Best value often requires active points strategy",
                "Not ideal if you rarely travel"
            ],
            watchFor: "Check if perks realistically offset the annual fee."
        ),
        CardTypeProfile(
            name: "Balance Transfer Card",
            icon: "arrow.left.arrow.right",
            popularity: "Common for debt payoff plans",
            bestFor: "Paying down existing card debt faster.",
            typicalAprRange: "0% intro, then 17% - 30% variable",
            annualFeeRange: "Usually $0",
            strengths: [
                "Intro APR can reduce short-term interest cost",
                "Useful for structured payoff plans",
                "Often available with no annual fee"
            ],
            tradeoffs: [
                "Transfer fee adds upfront cost",
                "Cost can rise sharply after intro ends",
                "Missed payments may void promo terms"
            ],
            watchFor: "Calculate transfer fee plus payoff timeline before choosing."
        ),
        CardTypeProfile(
            name: "Low APR Card",
            icon: "leaf",
            popularity: "Steady mainstream option",
            bestFor: "People who may occasionally carry a balance.",
            typicalAprRange: "14% - 23% variable",
            annualFeeRange: "Usually $0",
            strengths: [
                "Lower interest cost than many rewards cards",
                "Simple structure with fewer gimmicks",
                "Good baseline product for cost control"
            ],
            tradeoffs: [
                "Rewards can be limited",
                "Fewer premium perks",
                "Still expensive if balance is carried long-term"
            ],
            watchFor: "Compare ongoing APR and fee structure, not welcome bonuses."
        ),
        CardTypeProfile(
            name: "Secured Credit Builder Card",
            icon: "lock.shield",
            popularity: "Common beginner/rebuild product",
            bestFor: "Building or rebuilding credit history.",
            typicalAprRange: "20% - 30% variable",
            annualFeeRange: "$0 to $49",
            strengths: [
                "Accessible approval path for thin credit files",
                "Can help establish payment history",
                "Some cards allow upgrade to unsecured later"
            ],
            tradeoffs: [
                "Requires refundable security deposit",
                "Credit limits may start low",
                "APR can be high"
            ],
            watchFor: "Check reporting to all major bureaus and upgrade terms."
        )
    ]

    static let quizQuestions: [QuizQuestion] = [
        QuizQuestion(
            prompt: "If you carry a balance month to month, which detail usually matters most?",
            options: ["Regular APR", "Welcome bonus size", "Cash-back category list", "Card color"],
            answerIndex: 0,
            explanation: "Regular APR drives long-term interest cost when you carry debt month to month."
        ),
        QuizQuestion(
            prompt: "You transfer $2,400 to a card with a 5% transfer fee. What is the fee?",
            options: ["$24", "$120", "$240", "$480"],
            answerIndex: 1,
            explanation: "5% of $2,400 is $120 added up front."
        ),
        QuizQuestion(
            prompt: "Which offer can become expensive after intro APR ends if balance remains?",
            options: ["High regular APR card", "Card with metal finish", "Low regular APR card with short intro", "No annual fee card with moderate APR"],
            answerIndex: 0,
            explanation: "A long intro helps short term, but high regular APR can become expensive afterward."
        ),
        QuizQuestion(
            prompt: "What does paying only the minimum usually do?",
            options: ["Shortens payoff dramatically", "Can extend payoff and raise total interest", "Eliminates interest charges", "Improves APR instantly"],
            answerIndex: 1,
            explanation: "Minimum-only payments often reduce principal slowly, increasing time and interest."
        ),
        QuizQuestion(
            prompt: "What is a grace period for purchases?",
            options: ["Time to pay statement balance without purchase interest", "Extra credit limit window", "A rewards bonus period", "A period with no fees of any kind"],
            answerIndex: 0,
            explanation: "When eligible, paying the statement balance in full by due date avoids purchase interest."
        ),
        QuizQuestion(
            prompt: "A card has 0% intro APR for 12 months and 24% regular APR after. If balance remains after month 12, what happens?",
            options: ["0% continues until paid off", "Regular APR can apply to remaining balance", "Interest is waived permanently", "Only annual fee applies"],
            answerIndex: 1,
            explanation: "When intro ends, the regular APR can apply to any unpaid balance."
        ),
        QuizQuestion(
            prompt: "What is negative amortization risk?",
            options: ["Payment is too low to cover interest", "APR decreases monthly", "Balance transfer fee gets refunded", "Credit limit automatically doubles"],
            answerIndex: 0,
            explanation: "If payment does not cover interest, balance can stay flat or grow."
        ),
        QuizQuestion(
            prompt: "Why can annual fees matter even if you do not carry a balance?",
            options: ["They increase your monthly APR", "They are still a fixed yearly cost", "They cancel grace period", "They remove payment due dates"],
            answerIndex: 1,
            explanation: "Annual fees add to total card cost whether or not you pay interest."
        ),
        QuizQuestion(
            prompt: "If two cards have similar APR, which extra item can still change total cost a lot during transfer?",
            options: ["Welcome bonus value", "Transfer fee percentage", "Foreign transaction fee", "Card material"],
            answerIndex: 1,
            explanation: "A higher transfer fee adds immediate cost and can offset intro-rate benefits."
        ),
        QuizQuestion(
            prompt: "What is usually the best first step before choosing a card for carrying debt?",
            options: ["Compare regular APR, transfer fee, and intro term together", "Pick the highest rewards rate without checking APR", "Choose the longest intro period and ignore transfer fee", "Pick the card with the brightest design"],
            answerIndex: 0,
            explanation: "For carried balances, APR + fees + intro duration together shape total cost."
        )
    ]

    static func term(named name: String) -> CreditTerm? {
        creditTerms.first { $0.term.caseInsensitiveCompare(name) == .orderedSame }
    }
}
