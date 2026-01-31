#!/bin/bash

# Build script for web with Firebase configuration injection
# This script loads environment variables and injects them into web files

set -e

echo "🔧 Building Flutter web with Firebase configuration..."

# Load environment variables
if [ -f .env ]; then
    echo "📋 Loading environment variables from .env"
    export $(grep -v '^#' .env | xargs)
elif [ -n "$VERCEL" ]; then
    echo "🌐 Detected Vercel environment. Using Dashboard Environment Variables."
else
    echo "⚠️ Warning: .env file not found. Build will proceed using existing environment variables."
fi

# Create firebase-config.js with actual values
echo "🔥 Generating Firebase configuration for web..."
cat > web/firebase-config.js << EOF
// Firebase configuration for web
// This file is generated dynamically from environment variables
window.firebaseConfig = {
    apiKey: "${FIREBASE_API_KEY_WEB}",
    authDomain: "${FIREBASE_AUTH_DOMAIN}",
    projectId: "${FIREBASE_PROJECT_ID}",
    storageBucket: "${FIREBASE_STORAGE_BUCKET}",
    messagingSenderId: "${FIREBASE_MESSAGING_SENDER_ID}",
    appId: "${FIREBASE_APP_ID_WEB}",
    measurementId: "${FIREBASE_MEASUREMENT_ID}"
};
EOF

# Build Flutter web
echo "🚀 Building Flutter web application in release mode..."
flutter build web --release --base-href /

echo "✅ Web build completed successfully!"
echo "📁 Output directory: build/web"
echo "🔒 Firebase configuration injected securely"

# Optional: Copy firebase-config.js to build directory
cp web/firebase-config.js build/web/firebase-config.js

echo "🎉 Build process completed!"