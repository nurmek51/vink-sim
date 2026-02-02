#!/bin/bash

# Build script for web
# This script loads environment variables and injects them into web files

set -e

echo "🔧 Building Flutter web..."

# Load environment variables
if [ -f .env ]; then
    echo "📋 Loading environment variables from .env"
    export $(grep -v '^#' .env | xargs)
elif [ -n "$VERCEL" ]; then
    echo "🌐 Detected Vercel environment. Using Dashboard Environment Variables."
else
    echo "⚠️ Warning: .env file not found. Build will proceed using existing environment variables."
fi

# Generate .env for the Flutter app
echo "📝 Generating .env file for Flutter..."
# Hardcode the production URL as a default to ensure it works even if dashboard is empty
FINAL_API_URL=${API_URL:-"https://nurmek.site/"}
echo "📍 Using API_URL: $FINAL_API_URL"

cat > .env << EOF
API_URL=$FINAL_API_URL
API_URL_DEVELOPMENT=${API_URL_DEVELOPMENT:-"https://nurmek.site/"}
EOF

echo "🚀 Starting Flutter Web Build..."
flutter build web --release --no-tree-shake-icons

echo "✅ Web build complete!"
