import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            List {
                Section("Settings") {
                    Toggle(isOn: $themeManager.isDarkMode) {
                        Label("Dark Mode", systemImage: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                    }
                    .accessibilityLabel("Toggle dark mode")

                    NavigationLink {
                        ReminderSettingsView()
                    } label: {
                        Label("Daily Reminders", systemImage: "bell.fill")
                    }
                    .accessibilityLabel("Daily reminder settings")

                    NavigationLink {
                        PreferencesView()
                    } label: {
                        Label("Preferences", systemImage: "slider.horizontal.3")
                    }
                    .accessibilityLabel("App preferences")
                }

                Section("Data") {
                    Toggle(isOn: $dataManager.soundEffectsEnabled) {
                        Label("Sound Effects", systemImage: "speaker.wave.2.fill")
                    }
                    .accessibilityLabel("Toggle sound effects")

                    Toggle(isOn: $dataManager.voiceGuidanceEnabled) {
                        Label("Voice Guidance", systemImage: "waveform")
                    }
                    .accessibilityLabel("Toggle voice guidance")

                    Toggle(isOn: $dataManager.hapticEnabled) {
                        Label("Haptic Feedback", systemImage: "hand.tap.fill")
                    }
                    .accessibilityLabel("Toggle haptic feedback")
                }

                Section("About") {
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Label("Privacy Policy", systemImage: "lock.shield")
                    }
                    .accessibilityLabel("View privacy policy")

                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    .accessibilityLabel("App version 1.0.0")
                }

                Section {
                    Button(role: .destructive) {
                        dataManager.resetAllData()
                    } label: {
                        Label("Reset All Data", systemImage: "trash")
                    }
                    .accessibilityLabel("Reset all data")
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ReminderSettingsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var reminderEnabled = false
    @State private var reminderTime = Date()

    var body: some View {
        Form {
            Section {
                Toggle("Daily Reminder", isOn: $reminderEnabled)
                    .accessibilityLabel("Toggle daily reminder")
            }

            if reminderEnabled {
                Section("Time") {
                    DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .accessibilityLabel("Select reminder time")
                }
            }
        }
        .navigationTitle("Reminders")
    }
}

struct PreferencesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var preferredDuration = 10

    var body: some View {
        Form {
            Section("Preferred Duration") {
                Picker("Session Length", selection: $preferredDuration) {
                    Text("3 min").tag(3)
                    Text("5 min").tag(5)
                    Text("10 min").tag(10)
                    Text("15 min").tag(15)
                    Text("20 min").tag(20)
                    Text("30 min").tag(30)
                }
                .accessibilityLabel("Preferred meditation duration")
            }
        }
        .navigationTitle("Preferences")
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Last updated: 2026-04-27")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("MindfulFlow does not collect, store, or transmit any personal data to external servers. All data is stored locally on your device.")
                Text("We do not use any third-party analytics or advertising services.")
                Text("This app is not intended for children under 13 years of age.")
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    ProfileView()
        .environmentObject(DataManager())
        .environmentObject(ThemeManager())
}