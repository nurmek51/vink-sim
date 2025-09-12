#!/bin/bash

# Build script for production App Store release
echo "🚀 Building production release for App Store..."

# Ensure we're using production environment
echo "📦 Using production environment configuration"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get

# Build iOS for App Store
echo "📱 Building iOS for App Store..."
flutter build ios --release --no-codesign

# Build Android APK/AAB for production
echo "🤖 Building Android for production..."
flutter build apk --release
flutter build appbundle --release

echo "✅ Production build completed!"
echo "📋 Next steps:"
echo "  - iOS: Open Xcode and archive for App Store"
echo "  - Android: Upload the AAB to Google Play Console"
echo "  - Files location:"
echo "    - iOS: build/ios/iphoneos/Runner.app"
echo "    - Android APK: build/app/outputs/flutter-apk/app-release.apk" 
echo "    - Android AAB: build/app/outputs/bundle/release/app-release.aab"