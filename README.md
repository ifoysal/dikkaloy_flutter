# LiveMCQ3 Flutter App

A production-grade Flutter application consuming the LiveMCQ3 Laravel REST API (`/api/v1`).

## Prerequisites

- Flutter SDK (stable channel, >=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / Xcode for platform builds
- Firebase project for FCM

## Setup

```bash
cd flutterapp
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Dart Defines

Pass these at build/run time:

| Variable | Description | Example |
|----------|-------------|---------|
| `API_BASE_URL` | Backend API base URL (no trailing slash) | `http://10.0.2.2:8000` |
| `REVERB_APP_KEY` | Laravel Reverb app key | `app-key` |
| `REVERB_HOST` | Reverb WebSocket host | `wss://api.example.com` |
| `FCM_SENDER_ID` | Firebase sender ID | `123456789` |

**Local development:**
- Android emulator: `http://10.0.2.2:8000`
- iOS simulator: `http://localhost:8000`
- Physical device: `http://<your-pc-ip>:8000`

Example:

```bash
flutter run \
  --dart-define=API_BASE_URL=http://10.0.2.2:8000 \
  --dart-define=REVERB_APP_KEY=dikkhaloy_key \
  --dart-define=REVERB_HOST=wss://dikkhaloy.nothibazar.com.bd \
  --dart-define=FCM_SENDER_ID=123456789
```

## Build

Android:
```bash
flutter build apk --dart-define=API_BASE_URL=https://api.example.com ...
```

iOS:
```bash
flutter build ios --dart-define=API_BASE_URL=https://api.example.com ...
```

## Project Structure

```
lib/
  core/          # Shared utilities, networking, storage, theme
  features/      # Feature modules (auth, home, mcq, contest, jobs, books, cv, profile, notifications)
  routing/       # go_router configuration
  main.dart      # App entry point
```

## Testing

```bash
flutter test
```

## Notes

- Bengali (`bn`) is the primary locale; English (`en`) is secondary.
- Offline support uses Hive for downloaded questions, saved jobs, and library metadata.
- Payments integrate bKash via in-app WebView using the same backend checkout flow.
