import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedSession: MeditationSession?
    @State private var showingPlayer = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    streakSection
                    recommendedSection
                    quickActionsSection
                    recentSection
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .background(themeManager.isDarkMode ? Color(hex: "0F0F14") : Color(hex: "FAFAFA"))
            .navigationTitle("MindfulFlow")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        themeManager.isDarkMode.toggle()
                    } label: {
                        Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(Color(hex: "A78BFA"))
                    }
                    .accessibilityLabel(themeManager.isDarkMode ? "Switch to light mode" : "Switch to dark mode")
                }
            }
            .fullScreenCover(item: $selectedSession) { session in
                MeditationPlayerView(session: session)
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(greeting)
                .font(.title2)
                .fontWeight(.semibold)
            Text("Ready for your meditation?")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good morning" }
        else if hour < 17 { return "Good afternoon" }
        else { return "Good evening" }
    }

    private var streakSection: some View {
        HStack(spacing: 16) {
            StreakBadgeView(streak: dataManager.currentStreak, isDarkMode: themeManager.isDarkMode)
            MoodSelectorView(currentMood: $dataManager.todayMood, isDarkMode: themeManager.isDarkMode)
        }
    }

    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Recommendation")
                .font(.headline)
            if let session = dataManager.recommendedSession {
                MeditationCardView(session: session, isDarkMode: themeManager.isDarkMode) {
                    selectedSession = session
                }
            }
        }
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Start")
                .font(.headline)
            HStack(spacing: 12) {
                QuickActionButton(
                    icon: "wind",
                    title: "Breathing",
                    color: Color(hex: "A78BFA"),
                    isDarkMode: themeManager.isDarkMode
                ) {
                    // TODO: Navigate to breathing
                }
                QuickActionButton(
                    icon: "moon.fill",
                    title: "Sleep",
                    color: Color(hex: "6366F1"),
                    isDarkMode: themeManager.isDarkMode
                ) {
                    // TODO: Navigate to sleep
                }
                QuickActionButton(
                    icon: "waveform",
                    title: "Sounds",
                    color: Color(hex: "34D399"),
                    isDarkMode: themeManager.isDarkMode
                ) {
                    // TODO: Navigate to sounds
                }
            }
        }
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Continue")
                .font(.headline)
            ForEach(dataManager.recentSessions.prefix(3)) { session in
                MeditationRowView(session: session, isDarkMode: themeManager.isDarkMode) {
                    selectedSession = session
                }
            }
        }
    }
}

struct StreakBadgeView: View {
    let streak: Int
    let isDarkMode: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundColor(.orange)
            VStack(alignment: .leading) {
                Text("\(streak)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("day streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .accessibilityLabel("\(streak) day meditation streak")
    }
}

struct MoodSelectorView: View {
    @Binding var currentMood: Int
    let isDarkMode: Bool
    let moods = ["😔", "😕", "😐", "🙂", "😊"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("How are you?")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 8) {
                ForEach(0..<5) { index in
                    Button {
                        currentMood = index + 1
                    } label: {
                        Text(moods[index])
                            .font(.title3)
                            .padding(8)
                            .background(currentMood == index + 1 ? Color(hex: "A78BFA").opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("Mood \(index + 1): \(moods[index])")
                }
            }
        }
        .padding()
        .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let isDarkMode: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(isDarkMode ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .accessibilityLabel("\(title) quick action")
    }
}

struct MeditationCardView: View {
    let session: MeditationSession
    let isDarkMode: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        colors: [Color(hex: "A78BFA"), Color(hex: "7C5CBF")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "brain.head.profile")
                            .font(.title)
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(session.title)
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .primary)
                    Text(session.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text("\(session.duration / 60) min")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "play.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(hex: "A78BFA"))
            }
            .padding()
            .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .accessibilityLabel("Start \(session.title) meditation")
    }
}

struct MeditationRowView: View {
    let session: MeditationSession
    let isDarkMode: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "brain.head.profile")
                    .font(.title3)
                    .foregroundColor(Color(hex: "A78BFA"))
                    .frame(width: 40, height: 40)
                    .background(Color(hex: "A78BFA").opacity(0.2))
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 2) {
                    Text(session.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("\(session.duration / 60) min • \(session.category.rawValue)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "play.fill")
                    .font(.caption)
                    .foregroundColor(Color(hex: "A78BFA"))
            }
            .padding()
            .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
            .cornerRadius(12)
        }
        .accessibilityLabel("Resume \(session.title)")
    }
}

#Preview {
    HomeView()
        .environmentObject(DataManager())
        .environmentObject(ThemeManager())
}