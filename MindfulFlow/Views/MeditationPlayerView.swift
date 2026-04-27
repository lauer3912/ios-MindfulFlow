import SwiftUI

struct MeditationPlayerView: View {
    let session: MeditationSession
    @Environment(\.dismiss) var dismiss
    @State private var elapsed: Int = 0
    @State private var isPlaying = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            backgroundGradient

            VStack(spacing: 32) {
                header
                timerRing
                controls
                ambientAnimation
            }
            .padding()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color(hex: "0F0F14"), Color(hex: "1C1C1E"), Color(hex: "2C2C2E")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white.opacity(0.7))
            }
            .accessibilityLabel("Close meditation player")

            Spacer()

            Text(session.title)
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundColor(.white.opacity(0))
        }
    }

    private var timerRing: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 8)
                .frame(width: 250, height: 250)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(colors: [Color(hex: "A78BFA"), Color(hex: "7C5CBF")], startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))

            VStack(spacing: 8) {
                Text(timeString)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text(session.category.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }

    private var controls: some View {
        HStack(spacing: 48) {
            Button {
                skipBackward()
            } label: {
                Image(systemName: "gobackward.10")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .accessibilityLabel("Skip backward 10 seconds")

            Button {
                togglePlayPause()
            } label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 72))
                    .foregroundColor(Color(hex: "A78BFA"))
            }
            .accessibilityLabel(isPlaying ? "Pause meditation" : "Play meditation")

            Button {
                skipForward()
            } label: {
                Image(systemName: "goforward.10")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .accessibilityLabel("Skip forward 10 seconds")
        }
    }

    private var ambientAnimation: some View {
        HStack(spacing: 8) {
            ForEach(0..<5) { index in
                Circle()
                    .fill(Color(hex: "A78BFA").opacity(0.3 + Double(index) * 0.15))
                    .frame(width: CGFloat(20 + index * 10), height: CGFloat(20 + index * 10))
                    .animation(
                        isPlaying ?
                            Animation.easeInOut(duration: 2 + Double(index) * 0.3).repeatForever(autoreverses: true) :
                            .default,
                        value: isPlaying
                    )
            }
        }
        .padding(.top, 32)
    }

    private var progress: Double {
        guard session.duration > 0 else { return 0 }
        return min(Double(elapsed) / Double(session.duration), 1.0)
    }

    private var timeString: String {
        let remaining = max(session.duration - elapsed, 0)
        let minutes = remaining / 60
        let seconds = remaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer() {
        isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if elapsed < session.duration {
                elapsed += 1
            } else {
                completeSession()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isPlaying = false
    }

    private func togglePlayPause() {
        if isPlaying {
            timer?.invalidate()
            isPlaying = false
        } else {
            startTimer()
        }
    }

    private func skipBackward() {
        elapsed = max(elapsed - 10, 0)
    }

    private func skipForward() {
        elapsed = min(elapsed + 10, session.duration)
    }

    private func completeSession() {
        stopTimer()
        dismiss()
    }
}

#Preview {
    MeditationPlayerView(session: MeditationSession(
        id: UUID(),
        title: "Morning Calm",
        description: "Start your day peacefully",
        duration: 600,
        difficulty: .beginner,
        category: .calm
    ))
}