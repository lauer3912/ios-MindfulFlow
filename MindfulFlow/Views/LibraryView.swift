import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var themeManager: ThemeManager
    @State private var searchText = ""
    @State private var selectedCategory: MeditationCategory = .all
    @State private var selectedSession: MeditationSession?
    @State private var showingPlayer = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    searchBar
                    categoryPicker
                    sessionsList
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .background(themeManager.isDarkMode ? Color(hex: "0F0F14") : Color(hex: "FAFAFA"))
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(item: $selectedSession) { session in
                MeditationPlayerView(session: session)
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search meditations", text: $searchText)
                .textFieldStyle(.plain)
        }
        .padding()
        .background(themeManager.isDarkMode ? Color(hex: "1C1C1E") : .white)
        .cornerRadius(12)
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(MeditationCategory.allCases, id: \.self) { category in
                    CategoryChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category,
                        isDarkMode: themeManager.isDarkMode
                    ) {
                        selectedCategory = category
                    }
                }
            }
        }
    }

    private var sessionsList: some View {
        LazyVStack(spacing: 12) {
            ForEach(filteredSessions) { session in
                MeditationCardView(session: session, isDarkMode: themeManager.isDarkMode) {
                    selectedSession = session
                }
            }
        }
    }

    private var filteredSessions: [MeditationSession] {
        var sessions = dataManager.allSessions
        if selectedCategory != .all {
            sessions = sessions.filter { $0.category == selectedCategory }
        }
        if !searchText.isEmpty {
            sessions = sessions.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        return sessions
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let isDarkMode: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color(hex: "A78BFA") : (isDarkMode ? Color(hex: "1C1C1E") : .white))
                .foregroundColor(isSelected ? .white : (isDarkMode ? .white : .primary))
                .cornerRadius(20)
        }
        .accessibilityLabel("\(title) category, \(isSelected ? "selected" : "not selected")")
    }
}

#Preview {
    LibraryView()
        .environmentObject(DataManager())
        .environmentObject(ThemeManager())
}