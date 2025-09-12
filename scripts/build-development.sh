#!/bin/bash

# Build script for development/testing
echo "🔧 Building development version..."

# Clean and get dependencies
echo "🧹 Cleaning and getting dependencies..."
flutter clean
flutter pub get

# Build for debugging/testing
echo "📱 Building debug version..."
flutter build ios --debug
flutter build apk --debug

echo "✅ Development build completed!"
echo "📋 Debug builds ready for testing"