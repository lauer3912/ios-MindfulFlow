import SwiftUI

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