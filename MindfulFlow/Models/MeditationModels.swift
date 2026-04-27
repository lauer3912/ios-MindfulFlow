import Foundation

enum MeditationCategory: String, CaseIterable, Codable {
    case all = "All"
    case calm = "Calm"
    case sleep = "Sleep"
    case focus = "Focus"
    case stress = "Stress Relief"
    case morning = "Morning"
    case evening = "Evening"
}

enum MeditationDifficulty: String, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

struct MeditationSession: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let duration: Int
    let difficulty: MeditationDifficulty
    let category: MeditationCategory
}

struct BreathingPattern: Identifiable, Codable {
    let id: UUID
    let name: String
    let inhaleSeconds: Int
    let holdSeconds: Int
    let exhaleSeconds: Int
    let holdAfterExhaleSeconds: Int

    static let boxBreathing = BreathingPattern(
        id: UUID(),
        name: "Box Breathing",
        inhaleSeconds: 4,
        holdSeconds: 4,
        exhaleSeconds: 4,
        holdAfterExhaleSeconds: 4
    )

    static let relaxingBreath = BreathingPattern(
        id: UUID(),
        name: "4-7-8 Breathing",
        inhaleSeconds: 4,
        holdSeconds: 7,
        exhaleSeconds: 8,
        holdAfterExhaleSeconds: 0
    )
}

struct AmbientSound: Identifiable, Codable {
    let id: UUID
    let name: String
    let icon: String
    var isPlaying: Bool = false
    var volume: Float = 0.5
}

struct Achievement: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    var isUnlocked: Bool = false
    var unlockedDate: Date?
}

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let mood: Int
}

struct CalendarEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let minutes: Int
}