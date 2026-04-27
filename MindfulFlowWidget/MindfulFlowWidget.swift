import WidgetKit
import SwiftUI

struct MindfulFlowWidgetEntry: TimelineEntry {
    let date: Date
    let streak: Int
    let todayMinutes: Int
    let completed: Bool
}

struct MindfulFlowWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> MindfulFlowWidgetEntry {
        MindfulFlowWidgetEntry(date: Date(), streak: 7, todayMinutes: 10, completed: false)
    }

    func getSnapshot(in context: Context, completion: @escaping (MindfulFlowWidgetEntry) -> Void) {
        let entry = MindfulFlowWidgetEntry(date: Date(), streak: 7, todayMinutes: 10, completed: false)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MindfulFlowWidgetEntry>) -> Void) {
        let entry = MindfulFlowWidgetEntry(
            date: Date(),
            streak: UserDefaults.standard.integer(forKey: "streak"),
            todayMinutes: UserDefaults.standard.integer(forKey: "todayMinutes"),
            completed: UserDefaults.standard.bool(forKey: "todayCompleted")
        )
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct MindfulFlowWidgetEntryView: View {
    var entry: MindfulFlowWidgetProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.title2)
                    .foregroundColor(Color(hex: "A78BFA"))
                Text("MindfulFlow")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            Spacer()

            if entry.completed {
                Label("Done for today!", systemImage: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(Color(hex: "34D399"))
            } else {
                Text("\(entry.todayMinutes) min")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Start your meditation")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                Text("\(entry.streak) day streak")
                    .font(.caption)
            }
        }
        .padding()
        .if #available(iOS 17.0, *) {
            containerBackground(Color(UIColor.systemBackground), for: .widget)
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

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

@main
struct MindfulFlowWidget: Widget {
    let kind: String = "MindfulFlowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MindfulFlowWidgetProvider()) { entry in
            MindfulFlowWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("MindfulFlow")
        .description("Track your daily meditation streak.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}