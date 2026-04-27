import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }

    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}

struct AppColors {
    let primary = Color(hex: "A78BFA")
    let secondary = Color(hex: "7C5CBF")
    let accent = Color(hex: "34D399")

    static let lightBackground = Color(hex: "FAFAFA")
    static let lightSurface = Color(hex: "FFFFFF")
    static let lightTextPrimary = Color(hex: "1A1A2E")
    static let lightTextSecondary = Color(hex: "6B6B7B")

    static let darkBackground = Color(hex: "0F0F14")
    static let darkSurface = Color(hex: "1C1C1E")
    static let darkTextPrimary = Color(hex: "FFFFFF")
    static let darkTextSecondary = Color(hex: "9B9BAD")
}

struct AppTypography {
    static let heading1 = Font.system(size: 28, weight: .bold)
    static let heading2 = Font.system(size: 22, weight: .semibold)
    static let body = Font.system(size: 16, weight: .regular)
    static let caption = Font.system(size: 13, weight: .regular)
    static let button = Font.system(size: 16, weight: .semibold)
}