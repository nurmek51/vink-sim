#!/bin/bash

# Vercel Build Script for Flutter
# This script installs Flutter and builds the web application

set -e

# Define Flutter version
FLUTTER_VERSION="3.27.4" # Updated to match required Dart SDK version

echo "🟢 Starting Vercel Build Process..."

# 1. Download Flutter
echo "📥 Downloading Flutter SDK (version $FLUTTER_VERSION)..."
if [ ! -d "flutter" ]; then
    curl -C - -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
fi

# 2. Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# 2.5 Fix Git ownership issue for Flutter SDK
git config --global --add safe.directory `pwd`/flutter

# 3. Verify Flutter installation
echo "🔍 Verifying Flutter installation..."
flutter --version

# 4. Run the existing build-web script
# Note: scripts/build-web.sh expects a .env file. 
# On Vercel, environment variables should be set in the Dashboard.
# We modify build-web.sh logic or provide a dummy .env if needed.

echo "🔨 Running project build script..."
if [ -f "scripts/build-web.sh" ]; then
    chmod +x scripts/build-web.sh
    
    # Pre-build cleanup and setup
    flutter clean
    flutter pub get
    
    ./scripts/build-web.sh
else
    echo "❌ Error: scripts/build-web.sh not found."
    exit 1
fi

echo "✅ Vercel build finished!"
