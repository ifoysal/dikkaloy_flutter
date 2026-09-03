#!/bin/bash
# ==============================================================================
# Flutter User App Production Release APK Build Script
# ==============================================================================

set -e

echo "📱 Building LiveMCQ Production Release APK (Split Per ABI)..."

cd "$(dirname "$0")"

# 1. Clean Flutter Build Artifacts
flutter clean
flutter pub get

# 2. Run Test Suite
echo "🧪 Running unit & widget test suite..."
flutter test

# 3. Build Obfuscated Split Release APKs
echo "📦 Compiling release APKs..."
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=./build/app/outputs/symbols \
  --dart-define=API_BASE_URL=https://dikkhaloy.nothibazar.com.bd \
  --dart-define=REVERB_APP_KEY=dikkhaloy_key \
  --dart-define=REVERB_HOST=wss://dikkhaloy.nothibazar.com.bd

echo "✅ Production Release APKs Built Successfully:"
ls -lh build/app/outputs/flutter-apk/app-*.apk
