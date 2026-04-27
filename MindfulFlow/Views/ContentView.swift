import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            LibraryView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Library")
                }
                .tag(1)

            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(Color(hex: "A78BFA"))
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        .environmentObject(DataManager())
}