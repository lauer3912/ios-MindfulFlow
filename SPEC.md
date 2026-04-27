# MindfulFlow - Product Specification

## 1. Project Overview

**App Name:** MindfulFlow
**Bundle ID:** `com.ggsheng.MindfulFlow`
**Team:** ZhiFeng Sun (9L6N2ZF26B)

**Core Functionality:** A comprehensive meditation and mindfulness app that offers guided meditation sessions, breathing exercises, ambient sounds, sleep aids, mood tracking, and progress statistics. Available in dark and light themes with Apple Design Awards quality UI.

**Target Market:** Western markets (US, EU, UK, CA, AU) - Health & Wellness enthusiasts, stressed professionals, meditation beginners
**Monetization:** One-time purchase @ $9.99 (Premium Unlock)
**iOS Version Support:** iOS 17.0+

---

## 2. UI/UX Specification

### Screen Structure

1. **HomeScreen** - Main dashboard with daily recommendation and streak
2. **MeditationPlayerScreen** - Active meditation with timer, ambient animation, progress
3. **LibraryScreen** - Browse all meditation sessions by category
4. **SessionDetailScreen** - Session info before starting
5. **BreathingScreen** - Guided breathing exercises with visual patterns
6. **SoundsScreen** - Ambient sound mixer and presets
7. **SleepScreen** - Sleep stories and soundscape
8. **StatisticsScreen** - Calendar heatmap, weekly/monthly stats
9. **AchievementsScreen** - Unlock badges and milestones
10. **ProfileScreen** - User settings, preferences, reminders
11. **SettingsScreen** - App settings, data export
12. **OnboardingScreen** - First-time user flow

### Navigation Structure
- **UITabBarController** with 4 tabs:
  - Home (house icon)
  - Library (grid icon)
  - Stats (chart icon)
  - Profile (person icon)

### Visual Design

#### Color Palette

**Light Theme:**
- Primary: `#7C5CBF` (Deep Purple)
- Secondary: `#A78BFA` (Lavender)
- Accent: `#34D399` (Mint Green)
- Background: `#FAFAFA`
- Surface: `#FFFFFF`
- Text Primary: `#1A1A2E`
- Text Secondary: `#6B6B7B`

**Dark Theme:**
- Primary: `#A78BFA` (Bright Purple)
- Secondary: `#7C5CBF` (Medium Purple)
- Accent: `#6EE7B7` (Mint Green)
- Background: `#0F0F14`
- Surface: `#1C1C1E`
- Text Primary: `#FFFFFF`
- Text Secondary: `#9B9BAD`

#### Typography
- **Primary Font:** SF Pro Display
- **Heading 1:** 28pt Bold
- **Heading 2:** 22pt Semibold
- **Body:** 16pt Regular
- **Caption:** 13pt Regular
- **Button:** 16pt Semibold

#### Spacing System (8pt Grid)
- xs: 4pt
- sm: 8pt
- md: 16pt
- lg: 24pt
- xl: 32pt
- xxl: 48pt

### Views & Components

#### Reusable Components
- **MeditationCard** - Session card with thumbnail, title, duration, category
- **TimerRing** - Circular progress for meditation timer
- **BreathingCircle** - Animated circle for breathing exercises (inhale/hold/exhale)
- **SoundMixer** - Ambient sound mixer with multiple tracks
- **StreakBadge** - Current streak display with flame icon
- **CalendarHeatmap** - GitHub-style activity calendar
- **AchievementBadge** - Unlockable badge with progress ring
- **MoodSelector** - 5-point mood selection with emoji
- **ActionButton** - Primary CTA button with gradient
- **SegmentedPicker** - Duration/intensity selector
- **BottomSheet** - Modal for session options

---

## 3. Functionality Specification

### Core Features (60+)

#### Meditation & Playback (15)
1. Guided meditation session playback
2. Meditation timer with countdown
3. Pause/resume meditation
4. Skip to next section
5. Ambient background animation
6. Current session indicator
7. Total elapsed time display
8. Background audio continues when screen locked
9. Session completion celebration
10. Quick session restart
11. Session difficulty levels (Beginner/Intermediate/Advanced)
12. Session duration presets (3/5/10/15/20/30 min)
13. Session preview mode
14. Auto-play next session
15. Voice guidance narration

#### Library & Content (8)
16. Browse sessions by category
17. Browse sessions by duration
18. Browse sessions by mood
19. Favorite sessions
20. Recently played sessions
21. Recommended for you
22. Search sessions
23. Filter by difficulty
24. Sort by popularity/newest

#### Breathing Exercises (6)
25. Box breathing (4-4-4-4)
26. 4-7-8 breathing
27. Deep breathing
28. Energizing breath
29. Calming breath
30. Custom breathing pattern

#### Ambient Sounds (8)
31. Rain sounds
32. Forest/Nature sounds
33. Ocean/Waves
34. Fireplace crackling
35. White noise
36. Wind sounds
37. Birds chirping
38. Sound mixer (combine multiple)

#### Sleep Aid (5)
39. Sleep stories
40. Sleep timer
41. Sleep mode (auto-stop)
42. Gentle wake-up sounds
43. Sleep statistics

#### Mood & Tracking (8)
44. Daily mood logging
45. Mood history calendar
46. Mood trends chart
47. Meditation streak counter
48. Longest streak record
49. Weekly summary chart
50. Monthly summary chart
51. Total minutes meditated

#### Achievements & Gamification (5)
52. First meditation completed
53. 7-day streak badge
54. 30-day streak badge
55. 100 total minutes badge
56. Weekend warrior badge

#### Personalization (6)
57. Reminder notifications
58. Reminder time customization
59. Preferred session duration
60. Sound effects on/off
61. Voice guidance on/off
62. Haptic feedback on/off

#### Data & Sync (4)
63. iCloud data sync
64. Local data persistence
65. Session history export (JSON)
66. Reset all data

#### Settings (4)
67. Dark/Light theme toggle
68. Notification settings
69. Privacy Policy display
70. App version info

---

## 4. Technical Specification

### Architecture
- **Pattern:** MVVM (Model-View-ViewModel)
- **UI Framework:** SwiftUI
- **Minimum iOS:** 17.0 (required for Widget containerBackground)

### Dependencies (Swift Package Manager)
- None required for core functionality (using native SwiftUI)

### Data Models
- `MeditationSession` - Session definition
- `BreathingPattern` - Breathing exercise definition
- `AmbientSound` - Sound track definition
- `UserProgress` - Per-user tracking data
- `Achievement` - Achievement definition
- `UserSettings` - App preferences
- `MoodEntry` - Daily mood log

### Storage
- **UserDefaults** - User settings, preferences
- **SQLite (via SQLite.swift)** - Session data, progress records, mood entries
- **iCloud Key-Value Store** - Cross-device sync

### Assets Required
- App Icon (1024x1024 + all required sizes)
- Meditation illustration images (PNG, 750x750)
- Achievement badge images (PNG, 300x300)
- Tab bar icons (SF Symbols)
- Onboarding illustrations (3 screens)

---

## 5. Privacy & Compliance

- **Privacy Policy URL:** `https://lauer3912.github.io/ios-MindfulFlow/docs/PrivacyPolicy.html`
- **No HealthKit required**
- **No user accounts required**
- **All data stored locally**

---

## 6. App Store Metadata

**Keywords:** meditation, mindfulness, calm, relax, sleep, breathing, wellness, yoga, mental health, focus, stress relief, white noise, ambient sounds, guided meditation
**Category:** Health & Fitness
**Price:** $9.99 (USD) - One-time purchase, no subscriptions
**Content Rating:** 4+