import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    summarySection
                    streakSection
                    moodSection
                    calendarSection
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .background(themeManager.isDarkMode ? Color(hex: "0F0F14") : Color(hex: "FAFAFA"))
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var summarySection: some View {
        HStack(spacing: 16) {
            StatCard(
                title: "Total Minutes",
                value: "\(dataManager.totalMinutes)",
                icon: "clock.fill",
                color: Color(hex: "A78BFA"),
                isDarkMode: themeManager.isDarkMode
            )
            StatCard(
                title: "Sessions",
                value: "\(dataManager.totalSessions)",
                icon: "brain.head.profile",
                color: Color(hex: "34D399"),
                isDarkMode: themeManager.isDarkMode
            )
        }
    }

    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Streaks")
                .font(.headline)
            HStack(spacing: 16) {
                StreakDetailCard(
                    title: "Current",
                    value: "\(dataManager.currentStreak)",
                    icon: "flame.fill",
                    color: .orange,
                    isDarkMode: themeManager.isDarkMode
                )
                StreakDetailCard(
                    title: "Longest",
                    value: "\(dataManager.longestStreak)",
                    icon: "trophy.fill",
                    color: Color(hex: "FCD34D"),
                    isDarkMode: themeManager.isDarkMode
                )
            }
        }
    }

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mood Trend")
                .font(.headline)
            VStack(spacing: 8) {
                ForEach(dataManager.moodTrend, id: \.date) { entry in
                    HStack {
                        Text(entry.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(moodEmoji(for: entry.mood))
                            .font(.title3)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(themeManager.isDarkMode ? Color(hex: "1C1C1E") : .white)
            .cornerRadius(12)
        }
    }

    private var calendarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Activity Calendar")
                .font(.headline)
            CalendarHeatmapView(entries: dataManager.calendarEntries, isDarkMode: themeManager.isDarkMode)
                .padding()
                .background(themeManager.isDarkMode ? Color(hex: "1C1C1E") : .white)
                .cornerRadius(12)
        }
    }

    private func moodEmoji(for mood: Int) -> String {
        let moods = ["", "😔", "😕", "😐", "🙂", "😊"]
        return moods[safe: mood] ?? "😐"
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let isDarkMode: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct StreakDetailCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let isDarkMode: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isDarkMode ? Color(hex: "1C1C1E") : .white)
        .cornerRadius(12)
    }
}

struct CalendarHeatmapView: View {
    let entries: [CalendarEntry]
    let isDarkMode: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Last 30 Days")
                .font(.caption)
                .foregroundColor(.secondary)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 10), spacing: 4) {
                ForEach(entries) { entry in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(colorForMinutes(entry.minutes))
                        .frame(height: 20)
                }
            }
            HStack {
                Text("Less")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                ForEach([0, 5, 10, 20, 30], id: \.self) { minutes in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(colorForMinutes(minutes))
                        .frame(width: 16, height: 16)
                }
                Text("More")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func colorForMinutes(_ minutes: Int) -> Color {
        if minutes == 0 { return isDarkMode ? Color(hex: "1C1C1E") : Color(hex: "E5E7EB") }
        else if minutes < 5 { return Color(hex: "A78BFA").opacity(0.3) }
        else if minutes < 10 { return Color(hex: "A78BFA").opacity(0.5) }
        else if minutes < 20 { return Color(hex: "A78BFA").opacity(0.7) }
        else { return Color(hex: "A78BFA") }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    StatisticsView()
        .environmentObject(DataManager())
        .environmentObject(ThemeManager())
}