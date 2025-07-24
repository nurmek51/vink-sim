#!/bin/bash

# FlexTravelSIM - TestFlight Build Script
# Script for building and uploading to TestFlight

set -e

echo "🚀 Building FlexTravelSIM for TestFlight..."

# Check if we're in the correct directory
if [ ! -f "pubspec.yaml" ]; then
    echo "Error: Run this script from the Flutter project root"
    exit 1
fi

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Install CocoaPods dependencies
echo "Installing CocoaPods dependencies..."
cd ios
pod install
cd ..

# Generate build number
echo "Generating build number..."
BUILD_NUMBER=$(date +%Y%m%d%H%M)
echo "Build number: $BUILD_NUMBER"

# Create IPA file for TestFlight
echo "📱 Creating IPA file..."
flutter build ipa --build-number=$BUILD_NUMBER --export-options-plist=ios/ExportOptions.plist

# Find the created IPA file
IPA_FILE=$(find build/ios/ipa -name "*.ipa" -type f | head -1)

if [ -z "$IPA_FILE" ] || [ ! -f "$IPA_FILE" ]; then
    echo "Error: IPA file not found in build/ios/ipa/"
    exit 1
fi

echo "IPA file created successfully: $IPA_FILE"

# Upload to TestFlight via App Store Connect API
echo "Uploading to TestFlight..."
echo "You can use one of the following methods:"
echo ""
echo "1. Transporter (GUI):"
echo "   - Open Transporter from App Store"
echo "   - Drag and drop the file: $IPA_FILE"
echo "   - Click 'Deliver'"
echo ""
echo "2. Command line (if altool is configured):"
echo "   xcrun altool --upload-app -f \"$IPA_FILE\" -t ios -u \"YOUR_APPLE_ID\" -p \"APP_SPECIFIC_PASSWORD\""
echo ""
echo "3. Xcode Organizer:"
echo "   - Open Xcode → Window → Organizer"
echo "   - Click 'Distribute App'"
echo "   - Select 'App Store Connect'"
echo ""

echo "Build completed!"
echo "File location: $IPA_FILE"
echo "File size: $(du -h "$IPA_FILE" | cut -f1)"
echo ""
echo "Next steps:"
echo "   1. Upload the IPA file to TestFlight"
echo "   2. Wait for processing (usually 10-30 minutes)"
echo "   3. Add testers and send invitations"
echo "   4. Write release notes for testers"