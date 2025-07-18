# Localization Usage Guide

## Overview
This project uses `easy_localization` for internationalization. The system is designed to use static constants from `AppLocalizations` class for type-safe localization.

## Usage

### Basic Usage
Instead of using `Text('some_text')`, use `LocalizedText` with constants from `AppLocalizations`:

```dart
// ❌ Don't do this
Text('frame_title')

// ✅ Do this
LocalizedText(AppLocalizations.frameTitle)
```

### With Parameters
For text with parameters, use the `args` parameter:

```dart
// For text like "Step {}" use:
LocalizedText(
  AppLocalizations.stepNumber,
  args: ['1'],
)

// For text like "{}$ on account" use:
LocalizedText(
  AppLocalizations.dollarsOnAccount,
  args: ['15.00'],
)
```

### With Text Styling
Add styles using the `style` parameter:

```dart
LocalizedText(
  AppLocalizations.frameTitle,
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

### Complete Example
```dart
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocalizedText(AppLocalizations.frameTitle),
        LocalizedText(
          AppLocalizations.balance,
          style: const TextStyle(fontSize: 16),
        ),
        LocalizedText(
          AppLocalizations.stepNumber,
          args: ['1'],
        ),
      ],
    );
  }
}
```

## Language Switching
To change language programmatically:

```dart
import 'package:flex_travel_sim/core/localization/localization_service.dart';

// Change to Russian
LocalizationService.changeLanguage(context, 'ru');

// Change to English
LocalizationService.changeLanguage(context, 'en');

// Get current language
String currentLang = LocalizationService.getCurrentLanguage(context);
```

## Auto-Generation
The `AppLocalizations` class is **automatically generated** from JSON files. Never edit it manually!

### Adding New Translations
1. Add new key-value pairs to `assets/translations/en.json` and `assets/translations/ru.json`
2. Run the generation script:
   ```bash
   ./generate_localizations.sh
   # or
   dart tool/generate_localizations.dart
   ```
3. The new constants will be available in `AppLocalizations` class

### Example
Adding a new key:
```json
// assets/translations/en.json
{
  "new_feature_title": "New Feature"
}
```

After running the script, use it as:
```dart
LocalizedText(AppLocalizations.newFeatureTitle)
```

## Available Constants
All available translation keys are defined in `AppLocalizations` class using camelCase naming:

- `AppLocalizations.frameTitle` → 'frame_title'
- `AppLocalizations.yourTrafic` → 'your_trafic'
- `AppLocalizations.accountSettings` → 'account_settings'
- `AppLocalizations.topUpBalance` → 'top_up_balance'
- `AppLocalizations.testNewKey` → 'test_new_key'
- etc.

## Translation Files
Translation files are located in `assets/translations/`:
- `en.json` - English translations
- `ru.json` - Russian translations

## Key Naming Convention
- JSON keys use `snake_case`: `"frame_title"`
- Generated constants use `camelCase`: `AppLocalizations.frameTitle`
- Conversion is automatic via the generation script

## Benefits
1. **Type Safety**: Using constants prevents typos in translation keys
2. **IDE Support**: Auto-completion and refactoring support
3. **Maintainability**: Easy to find and update translation keys
4. **Consistency**: Standardized approach across the entire app
5. **Auto-Generation**: No manual work needed when adding new translations