import SwiftUI

class DataManager: ObservableObject {
    @Published var currentStreak: Int = 0
    @Published var longestStreak: Int = 0
    @Published var totalMinutes: Int = 0
    @Published var totalSessions: Int = 0
    @Published var todayMood: Int = 0
    @Published var soundEffectsEnabled: Bool = true
    @Published var voiceGuidanceEnabled: Bool = true
    @Published var hapticEnabled: Bool = true

    @Published var allSessions: [MeditationSession] = []
    @Published var recentSessions: [MeditationSession] = []
    @Published var recommendedSession: MeditationSession?
    @Published var moodTrend: [MoodEntry] = []
    @Published var calendarEntries: [CalendarEntry] = []

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        allSessions = [
            MeditationSession(id: UUID(), title: "Morning Calm", description: "Start your day peacefully", duration: 300, difficulty: .beginner, category: .morning),
            MeditationSession(id: UUID(), title: "Deep Sleep", description: "Drift into restful sleep", duration: 600, difficulty: .beginner, category: .sleep),
            MeditationSession(id: UUID(), title: "Focus Flow", description: "Sharpen your concentration", duration: 600, difficulty: .intermediate, category: .focus),
            MeditationSession(id: UUID(), title: "Stress Relief", description: "Release tension and anxiety", duration: 480, difficulty: .beginner, category: .stress),
            MeditationSession(id: UUID(), title: "Evening Wind Down", description: "Prepare for peaceful sleep", duration: 900, difficulty: .beginner, category: .evening),
            MeditationSession(id: UUID(), title: "Body Scan", description: "Deep relaxation practice", duration: 1200, difficulty: .intermediate, category: .calm),
            MeditationSession(id: UUID(), title: "Gratitude", description: "Cultivate appreciation", duration: 300, difficulty: .beginner, category: .calm),
            MeditationSession(id: UUID(), title: "Anxiety Relief", description: "Calm your anxious mind", duration: 600, difficulty: .beginner, category: .stress),
        ]
        recentSessions = Array(allSessions.prefix(3))
        recommendedSession = allSessions.first
        moodTrend = [
            MoodEntry(id: UUID(), date: Date().addingTimeInterval(-86400), mood: 4),
            MoodEntry(id: UUID(), date: Date().addingTimeInterval(-172800), mood: 3),
            MoodEntry(id: UUID(), date: Date().addingTimeInterval(-259200), mood: 5),
        ]
        calendarEntries = (0..<30).map { day in
            CalendarEntry(id: UUID(), date: Date().addingTimeInterval(-Double(day * 86400)), minutes: Int.random(in: 0...30))
        }
    }

    func resetAllData() {
        currentStreak = 0
        longestStreak = 0
        totalMinutes = 0
        totalSessions = 0
        todayMood = 0
        UserDefaults.standard.removeObject(forKey: "streak")
        UserDefaults.standard.removeObject(forKey: "totalMinutes")
    }
}