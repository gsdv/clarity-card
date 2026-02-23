import SwiftUI

struct ChoosingCardView: View {
    @StateObject private var viewModel = ChoosingCardViewModel()
    @State private var selectedProfileID: String = LocalDataStore.cardTypeProfiles.first?.id ?? ""

    var body: some View {
        ScreenContainer {
            Text("Card Type Explorer")
                .font(.system(.largeTitle, design: .rounded).weight(.black))

            Text("Compare popular card types and their tradeoffs before choosing.")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)

            profilesCarousel

            if let profile = viewModel.selectedProfile {
                profileDetailCard(profile)
            }

            CardContainer {
                Text("Quick Compare")
                    .font(ClarityTheme.titleFont)
                ForEach(viewModel.profiles) { profile in
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: profile.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(ClarityTheme.accentCool)
                            .frame(width: 28, height: 28)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(profile.name)
                                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                            Text(profile.bestFor)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Choosing A Card")
        .onAppear {
            if selectedProfileID.isEmpty {
                selectedProfileID = viewModel.profiles.first?.id ?? ""
            }
            syncSelectedProfile(id: selectedProfileID)
        }
        .onChange(of: selectedProfileID) { newValue in
            syncSelectedProfile(id: newValue)
        }
    }

    private var profilesCarousel: some View {
        VStack(spacing: 10) {
            TabView(selection: $selectedProfileID) {
                ForEach(Array(viewModel.profiles.enumerated()), id: \.element.id) { index, profile in
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(profileGradient(index: index))

                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(.white.opacity(0.34), lineWidth: 1)

                        VStack(alignment: .leading, spacing: 8) {
                            Label(profile.popularity, systemImage: "flame.fill")
                                .font(.system(.caption, design: .rounded).weight(.bold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.white.opacity(0.2), in: Capsule())
                                .foregroundStyle(.white)

                            Text(profile.name)
                                .font(.system(.title3, design: .rounded).weight(.bold))
                                .foregroundStyle(.white)

                            Text("Best for: \(profile.bestFor)")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.white.opacity(0.92))
                        }
                        .padding(18)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
                    .tag(profile.id)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Card type \(profile.name)")
                }
            }
            .frame(height: 200)
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack(spacing: 8) {
                ForEach(viewModel.profiles, id: \.id) { profile in
                    Circle()
                        .fill(profile.id == selectedProfileID ? ClarityTheme.accentCool : .secondary.opacity(0.35))
                        .frame(width: profile.id == selectedProfileID ? 8 : 7, height: profile.id == selectedProfileID ? 8 : 7)
                }
            }
            .accessibilityLabel("Card type pages")
        }
    }

    private func profileDetailCard(_ profile: CardTypeProfile) -> some View {
        CardContainer {
            HStack {
                Label(profile.name, systemImage: profile.icon)
                    .font(ClarityTheme.titleFont)
                Spacer()
            }

            detailRow(title: "Typical APR", value: profile.typicalAprRange)
            detailRow(title: "Annual Fee", value: profile.annualFeeRange)

            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Strengths")
                        .font(.system(.subheadline, design: .rounded).weight(.bold))
                    ForEach(profile.strengths, id: \.self) { item in
                        Text("• \(item)")
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white.opacity(0.33))
                )

                VStack(alignment: .leading, spacing: 6) {
                    Text("Tradeoffs")
                        .font(.system(.subheadline, design: .rounded).weight(.bold))
                    ForEach(profile.tradeoffs, id: \.self) { item in
                        Text("• \(item)")
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white.opacity(0.33))
                )
            }

            Text("Watch for: \(profile.watchFor)")
                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(ClarityTheme.accentSun.opacity(0.2))
                )
        }
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.system(.subheadline, design: .rounded).weight(.semibold))
        }
    }

    private func profileGradient(index: Int) -> LinearGradient {
        switch index % 5 {
        case 0:
            return LinearGradient(colors: [ClarityTheme.accentCool, ClarityTheme.accentLime], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 1:
            return LinearGradient(colors: [ClarityTheme.accentSun, ClarityTheme.accentWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 2:
            return LinearGradient(colors: [ClarityTheme.accentCoral, ClarityTheme.accentSun], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 3:
            return LinearGradient(colors: [ClarityTheme.accentCool, ClarityTheme.accentWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(colors: [ClarityTheme.accentLime, ClarityTheme.accentCool], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    private func syncSelectedProfile(id: String) {
        if let profile = viewModel.profiles.first(where: { $0.id == id }) {
            viewModel.selectedProfile = profile
        }
    }
}
