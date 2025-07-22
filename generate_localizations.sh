#!/bin/bash

# Script to regenerate AppLocalizations from JSON files

echo "Regenerating AppLocalizations..."

# Check if we're in the correct directory
if [ ! -d "assets/translations" ]; then
  echo "❌ Error: Run this script from the project root directory"
  exit 1
fi

# Run the Dart script
dart tool/generate_localizations.dart

# Check if the script succeeded
if [ $? -eq 0 ]; then
  echo "AppLocalizations regenerated successfully!"
  echo "📝 Don't forget to run 'flutter packages get' if needed"
else
  echo "Error: Failed to regenerate AppLocalizations"
  exit 1
fi