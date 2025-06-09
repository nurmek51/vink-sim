# FlexTravelSIM - Project Documentation

### Design Patterns
- **BLoC Pattern** - for state management
- **Feature-based Architecture** - modular structure
- **Repository Pattern** - for data layer
- **Dependency Injection** - for dependency management

### Project Structure

```
lib/
├── core/                    # Core components
│   ├── di/                 # Dependency Injection
│   ├── error/              # Error handling
│   ├── router/             # Navigation
│   ├── styles/             # App styles
│   └── usecases/           # Use Cases
├── features/               # App modules
│   ├── authentication/     # Authentication
│   ├── dashboard/          # Main screen
│   ├── onboarding/         # App introduction
│   ├── esim_management/    # eSIM management
│   ├── balance_management/ # Balance management
│   ├── settings/           # Settings
│   └── ...
├── shared/                 # Reusable components
│   └── widgets/            # Common widgets
├── components/             # UI components
│   └── widgets/            # Base widgets
├── constants/              # Constants
├── utils/                  # Utilities
└── gen/                   # Generated files
```

## Technology Stack

### Main Dependencies

| Package        | Version | Purpose           |
| -------------- | ------- | ----------------- |
| `flutter_bloc` | ^8.1.6  | State management  |
| `go_router`    | ^14.6.2 | Navigation        |
| `flutter_svg`  | ^2.1.0  | SVG support       |
| `http`         | ^1.4.0  | HTTP requests     |
| `equatable`    | ^2.0.5  | Object comparison |

### Development Tools
- **Flutter Gen** - typed asset generation
- **Flutter Lints** - code analysis
- **BLoC Test** - BLoC component testing

## Application Modules

### 1. Authentication (`lib/features/authentication/`)
**Purpose:** User authentication via phone number

**Components:**
- `AuthScreen` - phone number input screen
- `MobileNumberField` - number input field
- `RegistrationContainer` - registration container

### 2. Onboarding (`lib/features/onboarding/`)
**Purpose:** User introduction to the application

**Components:**
- `WelcomeScreen` - welcome screen
- `WelcomeCubit` - welcome screen state management
- `ResendCodeTimerCubit` - resend code timer

### 3. Dashboard (`lib/features/dashboard/`)
**Purpose:** Main screen with eSIM and traffic information

**Components:**
- `MainFlowScreen` - main screen
- `MainFlowBloc` - main screen state management
- `PercentageWidget` - percentage display widget
- `ChatContainer` - support chat container

### 4. eSIM Management (`lib/features/esim_management/`)
**Purpose:** eSIM card management

**Components:**
- `EsimSetupPage` - eSIM setup page
- `EsimSetupCubit` - setup state management

### 5. Balance Management (`lib/features/balance_management/`)
**Purpose:** Balance top-up and management

**Components:**
- `TopUpBalanceScreen` - balance top-up screen
- `TopUpBalanceCubit` - top-up state management
- `PaymentTypeSelector` - payment method selector

### 6. Settings (`lib/features/settings/`)
**Purpose:** Application and profile settings

**Components:**
- `SettingsScreen` - settings screen
- `PurchaseHistoryScreen` - purchase history
- `LanguageScreen` - language selection

## UI/UX Components

### Shared Widgets (`lib/shared/widgets/`)

#### BlueGradientButton
```dart
BlueGradientButton(
  title: "Confirm",
  onTap: () => _handleConfirm(),
)
```

#### Header
```dart
Header(
  color: Colors.white,
  avatarOnTap: () => _openProfile(),
  faqOnTap: () => _openFAQ(),
)
```

#### StepContainer
```dart
StepContainer(
  iconPath: Assets.icons.simIcon.path,
  stepNum: "1",
  description: "Step description",
)
```

### Components (`lib/components/widgets/`)

#### HelveticaneueFont
Custom text widget with Helvetica Neue font:
```dart
HelveticaneueFont(
  text: "Text",
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
)
```

## Navigation

### Application Routes

| Route             | Name         | Description    |
| ----------------- | ------------ | -------------- |
| `/`               | welcome      | Welcome screen |
| `/auth`           | auth         | Authentication |
| `/initial`        | initial      | Initial screen |
| `/main-flow`      | mainFlow     | Main screen    |
| `/esim-setup`     | esimSetup    | eSIM setup     |
| `/top-up-balance` | topUpBalance | Balance top-up |
| `/settings`       | settings     | Settings       |

### Screen Transitions

```dart
// Navigate to main screen
context.goNamed(AppRoutes.mainFlowName);

// Navigate with parameters
context.pushNamed(
  AppRoutes.esimSetupName,
  extra: {'esimId': esimId},
);
```

## Design System

### Colors (`lib/constants/app_colors.dart`)

```dart
class AppColors {
  static const containerGradientPrimary = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
  );
  
  static const backgroundPrimary = Color(0xFFF8F9FA);
  static const textPrimary = Color(0xFF363C45);
}
```

### Typography

**Font Family:** Helvetica Neue
- Regular (400) - body text
- Medium (500) - subheadings
- Bold (700) - headings

### Assets

All assets are typed via `flutter_gen`:

```dart
// Icons
Assets.icons.mainIcon.svg()
Assets.icons.avatarIcon.svg()
Assets.icons.simIcon.svg()

// Usage in code
SvgPicture.asset(Assets.icons.mainIcon.path)
```

## State Management

### BLoC Pattern

The application uses BLoC for state management:

```dart
// Cubit for simple states
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());
  
  void nextStep() {
    emit(WelcomeNextStep());
  }
}

// Bloc for complex logic
class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(MainFlowInitial()) {
    on<LoadTrafficData>(_onLoadTrafficData);
  }
}
```

### Providers

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => WelcomeCubit()),
    BlocProvider(create: (_) => MainFlowBloc()),
  ],
  child: MaterialApp.router(...),
)
```

## Development and Setup

### Requirements
- Flutter SDK ≥ 3.7.2
- Dart SDK ≥ 3.0.0
- Android Studio / VS Code
- Git

### Installation and Running

```bash
# Clone repository
git clone <repository-url>
cd flex_travel_sim

# Install dependencies
flutter pub get

# Generate assets
flutter packages pub run build_runner build

# Run on emulator
flutter run

# Build for release
flutter build apk --release
```

## 📱 Build and Deployment

### Android

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App Bundle for Google Play
flutter build appbundle --release
```

### iOS

```bash
# Build for simulator
flutter build ios --simulator

# Build for device
flutter build ios --release
```

### Web

```bash
# Build for web
flutter build web --release
```

## Configuration

### Android (`android/app/build.gradle.kts`)

- **compileSdk:** Flutter default
- **minSdk:** Flutter default  
- **targetSdk:** Flutter default
- **Java Version:** 11
- **Kotlin:** Latest

### iOS (`ios/Runner/Info.plist`)

- **Bundle ID:** com.example.flex_travel_sim
- **iOS Version:** 12.0+
- **Orientation:** Portrait

## Debugging and Profiling

### Flutter Inspector
Use Flutter Inspector for widget analysis:
```bash
flutter inspector
```

### Performance
Performance profiling:
```bash
flutter run --profile
```

### Logging
```dart
import 'dart:developer' as developer;

developer.log('Debug message', name: 'FlexTravelSIM');
```

## TODO and Development Plans

### Short-term Tasks
- [x] ~~Fix imports in `app_router.dart`~~ ✅ **Completed**
- [ ] Add unit tests for Cubits
- [ ] Set up CI/CD pipeline
- [ ] Add internationalization

### Long-term Plans
- [ ] Real API integration
- [ ] Push notifications
- [ ] Analytics and metrics
- [ ] Dark theme
- [ ] Offline mode
