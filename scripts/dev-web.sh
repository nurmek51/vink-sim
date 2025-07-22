#!/bin/bash

# Development script for web with Firebase configuration injection
# This script loads environment variables and starts development server

set -e

echo "🔧 Starting Flutter web development server..."

# Load environment variables
if [ -f .env ]; then
    echo "📋 Loading environment variables from .env"
    export $(grep -v '^#' .env | xargs)
else
    echo "❌ Error: .env file not found"
    exit 1
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

# Start Flutter web development server
echo "🚀 Starting Flutter web development server..."
flutter run -d chrome --web-port=8080

echo "✅ Development server started!"