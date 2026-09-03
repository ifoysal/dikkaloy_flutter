# Dikkhaloy Flutter (দিক্বালয়)

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![State Management](https://img.shields.io/badge/Riverpod-2.x-green?style=for-the-badge)
![Maintained By](https://img.shields.io/badge/Maintained%20By-Nothibazar-blueviolet?style=for-the-badge&link=https://nothibazar.com.bd)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-orange?style=for-the-badge)

**A high-performance coaching, competitive exam preparation, and career development platform.**

### Developed and Maintained by [Nothibazar](https://nothibazar.com.bd)
*Empowering learners and job seekers with modern digital educational infrastructure.*

---

[Website](https://nothibazar.com.bd) • [GitHub Repository](https://github.com/ifoysal/dikkaloy_flutter) • [API Specs](API_GAPS.md)

</div>

---

## 📖 Overview

**Dikkhaloy** is an educational and career companion app built with Flutter and backed by a Laravel REST API. It offers live MCQ model tests, real-time competitive contests, career circulars, an automated CV builder, digital book store, and carrier-grade monetization via bKash and Direct Carrier Billing (BdApps/Telco).

Designed from the ground up with **Clean Architecture** and **Riverpod**, the application guarantees optimal speed, responsive UI, offline resilience, and bilingual accessibility (Bengali and English).

---

## ✨ Key Features

### 🎯 1. Interactive MCQ & Model Tests
- **Categorized Practice**: Browse through subjects, chapters, and question pools.
- **Timed Exam Engine**: Realistic exam simulation with automatic countdown timers and answer tracking.
- **Instant Result Analytics**: Detailed performance report cards, accuracy rates, and weak-area diagnosis.
- **Offline Mode**: Download questions and practice offline using local SQLite/Hive caching.

### 🏆 2. Live Contests & Real-Time Arena
- **Real-Time Contests**: Scheduled competitive exams with synchronized start and end times.
- **WebSocket Broadcasts**: Live leaderboard standings and submission broadcasts powered by Laravel Reverb.
- **Contest Analytics**: Nationwide and batch-specific rank distributions.

### 💼 3. Job Circulars & Career Tracker
- **Smart Job Search**: Filter by government (BCS, Bank, Primary) and private job categories.
- **Alerts & Reminders**: Instant push notifications for application deadlines and exam schedules.
- **Application Tracking**: Bookmark job postings and track submission stages.

### 📄 4. In-App CV Builder
- **Professional Templates**: Generate standardized, recruiter-ready curriculum vitae.
- **Dynamic Section Editor**: Easily manage education, work experience, skills, and references.
- **Instant PDF Export**: Print or export formatted PDF resumes directly from your mobile device.

### 📚 5. Digital Bookstore & PDF Reader
- **E-Book Catalog**: Discover preparation guides, lecture sheets, and past question compilations.
- **Integrated PDF Viewer**: Smooth, encrypted document rendering using Syncfusion PDF Viewer.
- **Order Tracking**: Purchase history and reading status management.

### 💳 6. Flexible Monetization & Payments
- **bKash Payment Gateway**: Seamless mobile financial service transactions via in-app WebView.
- **Direct Carrier Billing (DCB)**: Telco subscription support powered by BdApps SMS and carrier billing.

### 🔔 7. Notifications & Biometrics
- **Multi-channel Messaging**: Firebase Cloud Messaging (FCM) + high-priority local background notifications.
- **App Lock**: Biometric fingerprint / face unlock authentication powered by `local_auth`.

---

## 🏗️ Architecture & Technology Stack

```
lib/
├── app.dart                    # App initialization & theme
├── main.dart                   # Application entry point
├── core/
│   ├── constants/              # App constants, API endpoints, assets
│   ├── l10n/                   # Bengali & English localization
│   ├── network/                # Dio HTTP client, interceptors, Firebase config
│   ├── storage/                # Hive local storage & FlutterSecureStorage
│   ├── theme/                  # Color palettes, typography, theme mode
│   └── utils/                  # Helpers, validators, logger
├── features/
│   ├── auth/                   # Authentication (OTP, Phone, Token)
│   ├── books/                  # Digital bookstore & order flows
│   ├── carrier_billing/        # BdApps DCB SMS subscription
│   ├── contest/ / contests/    # Live arena, WebSockets, leaderboards
│   ├── courses/                # Video & structured coaching modules
│   ├── cv/                     # Career CV builder & export
│   ├── home/                   # Dashboard & featured widgets
│   ├── jobs/                   # Job circulars & applications
│   ├── mcq/                    # Exam engine, questions, analytics
│   ├── notifications/          # FCM handler & preferences
│   ├── profile/                # User profile, app lock, settings
│   ├── quiz/                   # Daily quick quizzes
│   └── syllabus/               # Exam syllabi explorer
└── routing/
    ├── app_router.dart         # Declarative GoRouter setup
    └── routes.dart             # Named route constants
```

| Layer | Technology / Package |
|---|---|
| **Framework** | [Flutter](https://flutter.dev) (v3.x) & [Dart](https://dart.dev) (v3.x) |
| **State Management** | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + Code Generation |
| **Networking** | [Dio](https://pub.dev/packages/dio) & [web_socket_channel](https://pub.dev/packages/web_socket_channel) |
| **Local Storage** | [Hive](https://pub.dev/packages/hive) & [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| **Routing** | [go_router](https://pub.dev/packages/go_router) |
| **Push Notifications** | [firebase_messaging](https://pub.dev/packages/firebase_messaging) & [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| **PDF Viewer** | [syncfusion_flutter_pdfviewer](https://pub.dev/packages/syncfusion_flutter_pdfviewer) |
| **Payment Integration**| [webview_flutter](https://pub.dev/packages/webview_flutter) (bKash Checkout) |

---

## 🚀 Getting Started

### Prerequisites

Ensure the following tools are installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.0.0)
- [Dart SDK](https://dart.dev/get-dart) (>= 3.0.0)
- [Android Studio](https://developer.android.com/studio) (Android SDK 37 recommended) / [Xcode](https://developer.apple.com/xcode/) (macOS)
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ifoysal/dikkaloy_flutter.git
   cd dikkaloy_flutter
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation (Riverpod, JSON Serializable, Hive):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## ⚙️ Environment Configuration (Dart Defines)

The app utilizes compile-time `--dart-define` variables for backend URL, WebSocket connections, and Firebase settings:

| Parameter | Type | Default / Example | Purpose |
|---|---|---|---|
| `API_BASE_URL` | String | `https://dikkhaloy.nothibazar.com.bd` | LiveMCQ3 REST API Base URL |
| `REVERB_APP_KEY`| String | `dikkhaloy_key` | Laravel Reverb WebSocket key |
| `REVERB_HOST` | String | `wss://dikkhaloy.nothibazar.com.bd` | WebSocket server host |
| `FCM_SENDER_ID` | String | `123456789` | Firebase Cloud Messaging Sender ID |

### Running in Development

- **Localhost / Physical Device:**
  ```bash
  flutter run \
    --dart-define=API_BASE_URL=https://dikkhaloy.nothibazar.com.bd \
    --dart-define=REVERB_APP_KEY=dikkhaloy_key \
    --dart-define=REVERB_HOST=wss://dikkhaloy.nothibazar.com.bd
  ```

- **Android Emulator (Local backend):**
  ```bash
  flutter run \
    --dart-define=API_BASE_URL=http://10.0.2.2:8000
  ```

---

## 📦 Building for Production

### Android

Generate a release APK or Google Play App Bundle (AAB):

```bash
# Build Universal APK
flutter build apk --release --dart-define=API_BASE_URL=https://dikkhaloy.nothibazar.com.bd

# Build App Bundle for Play Store
flutter build appbundle --release --dart-define=API_BASE_URL=https://dikkhaloy.nothibazar.com.bd
```

### iOS

```bash
flutter build ipa --release --dart-define=API_BASE_URL=https://dikkhaloy.nothibazar.com.bd
```

---

## 🧪 Testing & Code Quality

Run tests to verify business logic, scoring algorithms, and repository handlers:

```bash
# Run unit & widget tests
flutter test

# Run code analyzer
flutter analyze
```

---

## 🏢 About Nothibazar

**[Nothibazar](https://nothibazar.com.bd)** provides technology platforms and software solutions designed to simplify, scale, and elevate coaching institutes, academic organizations, and career development initiatives across Bangladesh.

- **Official Website**: [https://nothibazar.com.bd](https://nothibazar.com.bd)
- **Contact & Inquiries**: info@nothibazar.com.bd

---

## 📄 License & Intellectual Property

Copyright © 2026 **[Nothibazar](https://nothibazar.com.bd)**. All rights reserved.

Proprietary software. Unauthorized copying, modification, or distribution of this code or any portion of it via any medium is strictly prohibited.
