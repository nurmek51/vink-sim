# FlexTravelSIM - Complete Project Documentation

## 📱 Project Overview

**FlexTravelSIM** is a modern Flutter application for managing eSIM cards for travelers. The app provides seamless eSIM purchasing, activation, and management with an intuitive user interface and robust backend integration.

## 🏗️ Architecture Overview

### Design Patterns
- **Clean Architecture** - Domain-driven design with clear layer separation
- **BLoC Pattern** - Reactive state management
- **Repository Pattern** - Abstracted data layer with caching
- **Dependency Injection** - Service locator pattern for dependency management
- **Either Pattern** - Functional error handling

### Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   BLoC/     │  │   Pages     │  │      Widgets        │  │
│  │   Cubit     │  │             │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                     DOMAIN LAYER                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  Use Cases  │  │  Entities   │  │   Repositories      │  │
│  │             │  │             │  │   (Interfaces)      │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                      DATA LAYER                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ Repositories│  │   Models    │  │   Data Sources      │  │
│  │(Implements) │  │             │  │ Remote │ Local      │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                      CORE LAYER                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ API Client  │  │ Local       │  │ Error Handling      │  │
│  │             │  │ Storage     │  │ & DI Container      │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
lib/
├── core/                    # Core infrastructure
│   ├── di/                 # Dependency Injection
│   │   └── injection_container.dart
│   ├── error/              # Error handling
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/            # HTTP client
│   │   └── api_client.dart
│   ├── storage/            # Local storage
│   │   └── local_storage.dart
│   ├── router/             # Navigation
│   │   ├── app_router.dart
│   │   └── route_guard.dart
│   └── styles/             # App styles
├── features/               # Feature modules
│   ├── esim_management/    # eSIM management feature
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── esim_model.dart
│   │   │   ├── data_sources/
│   │   │   │   ├── esim_remote_data_source.dart
│   │   │   │   └── esim_local_data_source.dart
│   │   │   └── repositories/
│   │   │       └── esim_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── esim.dart
│   │   │   ├── repositories/
│   │   │   │   └── esim_repository.dart
│   │   │   └── use_cases/
│   │   │       ├── get_esims_use_case.dart
│   │   │       ├── activate_esim_use_case.dart
│   │   │       └── purchase_esim_use_case.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── esim_bloc.dart
│   │       ├── pages/
│   │       └── widgets/
│   ├── user_account/       # User management feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── authentication/     # Authentication
│   ├── dashboard/          # Main screen
│   ├── onboarding/         # App introduction
│   ├── balance_management/ # Balance management
│   ├── settings/           # Settings
│   └── tariffs_and_countries/ # Tariffs & countries
├── shared/                 # Reusable components
│   └── widgets/            # Common widgets
├── components/             # UI components
│   └── widgets/            # Base widgets
├── constants/              # Constants
│   ├── app_colors.dart
│   └── localization.dart
├── utils/                  # Utilities
│   └── navigation_utils.dart
└── gen/                   # Generated files
    ├── assets.gen.dart
    └── fonts.gen.dart
```

## 🚀 Technology Stack

### Core Dependencies

| Package              | Version  | Purpose                    |
|---------------------|----------|----------------------------|
| `flutter_bloc`      | ^8.1.6   | State management          |
| `go_router`         | ^14.6.2  | Navigation                |
| `flutter_svg`       | ^2.1.0   | SVG support               |
| `http`              | ^1.4.0   | HTTP requests             |
| `equatable`         | ^2.0.5   | Object comparison         |
| `shared_preferences`| ^2.2.2   | Local storage             |

### Development Tools
- **Flutter Gen** - Typed asset generation
- **Flutter Lints** - Code analysis
- **Build Runner** - Code generation

## 📦 Data Layer Architecture

### Core Components

#### 🌐 API Client
```dart
class ApiClient {
  Future<Map<String, dynamic>> get(String endpoint) async {
    // Unified HTTP GET with error handling
  }
  
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    // Unified HTTP POST with error handling
  }
}
```

#### 💾 Local Storage
```dart
abstract class LocalStorage {
  Future<void> setJson(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> getJson(String key);
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
}
```

#### ⚠️ Error Handling
```dart
// Exceptions (Data Layer)
class ServerException implements Exception {
  final String message;
  final int? statusCode;
}

// Failures (Domain Layer)  
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

// Either Pattern
Future<Either<Failure, List<Esim>>> getEsims();
```

### Repository Pattern Implementation

```dart
class EsimRepositoryImpl implements EsimRepository {
  final EsimRemoteDataSource remoteDataSource;
  final EsimLocalDataSource localDataSource;

  Future<Either<Failure, List<Esim>>> getEsims({bool forceRefresh = false}) async {
    try {
      // 1. Check cache if not forcing refresh
      if (!forceRefresh) {
        final cached = await localDataSource.getCachedEsims();
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
      }

      // 2. Fetch from server
      final esims = await remoteDataSource.getEsims();
      
      // 3. Cache the results
      await localDataSource.cacheEsims(esims);
      
      return Right(esims.map((e) => e.toEntity()).toList());
    } on NetworkException {
      // 4. Fallback to cache on network error
      final cached = await localDataSource.getCachedEsims();
      if (cached.isNotEmpty) {
        return Right(cached.map((e) => e.toEntity()).toList());
      }
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
```

## 🎯 Feature Modules

### 1. eSIM Management (`lib/features/esim_management/`)

**Purpose:** Complete eSIM lifecycle management

**Entities:**
```dart
class Esim {
  final String id;
  final String name;
  final String provider;
  final String country;
  final double dataUsed;
  final double dataLimit;
  final bool isActive;
  final DateTime? expirationDate;
  
  double get dataUsagePercentage => dataUsed / dataLimit;
  bool get isExpired => expirationDate?.isBefore(DateTime.now()) ?? false;
}
```

**Use Cases:**
- `GetEsimsUseCase` - Retrieve user's eSIMs
- `ActivateEsimUseCase` - Activate eSIM with validation
- `PurchaseEsimUseCase` - Purchase new eSIM with payment processing

**BLoC Integration:**
```dart
class EsimBloc extends Bloc<EsimEvent, EsimState> {
  final GetEsimsUseCase getEsimsUseCase;
  
  Future<void> _onLoadEsims(LoadEsimsEvent event, Emitter<EsimState> emit) async {
    emit(EsimLoading());
    
    final result = await getEsimsUseCase(forceRefresh: event.forceRefresh);
    
    result.fold(
      (failure) => emit(EsimError(failure.message)),
      (esims) => emit(EsimLoaded(esims)),
    );
  }
}
```

### 2. User Account (`lib/features/user_account/`)

**Purpose:** User profile and authentication management

**Entities:**
```dart
class User {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final double balance;
  final String currency;
  final bool isEmailVerified;
  
  String get fullName => '$firstName $lastName'.trim();
  String get formattedBalance => '${balance.toStringAsFixed(2)} $currency';
  bool get isProfileComplete => firstName != null && lastName != null;
}
```

**Use Cases:**
- `GetCurrentUserUseCase` - Get current user data
- `UpdateUserProfileUseCase` - Update user profile with validation

### 3. Authentication (`lib/features/authentication/`)

**Components:**
- `AuthScreen` - Phone number input screen
- `MobileNumberField` - Formatted number input
- `RegistrationContainer` - Registration form

### 4. Dashboard (`lib/features/dashboard/`)

**Purpose:** Main screen with eSIM overview and quick actions

**Components:**
- `MainFlowScreen` - Main dashboard
- `MainFlowScreenImproved` - Version with new Data Layer integration
- `PercentageWidget` - eSIM usage visualization
- `ExpandedContainer` - Action buttons

**BLoC Integration:**
```dart
BlocBuilder<EsimBloc, EsimState>(
  builder: (context, state) {
    final esims = _getEsimsFromState(state);
    return PageView.builder(
      itemCount: esims.length,
      itemBuilder: (context, index) {
        return PercentageWidget(
          progressValue: esims[index].dataUsagePercentage,
          esim: esims[index],
        );
      },
    );
  },
)
```

### 5. Balance Management (`lib/features/balance_management/`)

**Components:**
- `TopUpBalanceScreen` - Balance top-up interface
- `TopUpBalanceCubit` - Top-up state management
- `PaymentTypeSelector` - Payment method selection

### 6. Settings (`lib/features/settings/`)

**Components:**
- `SettingsScreen` - Main settings
- `PurchaseHistoryScreen` - Transaction history
- `LanguageScreen` - Language selection
- `MyAccountScreen` - Profile management

## 🎨 UI/UX Components

### Shared Widgets (`lib/shared/widgets/`)

#### BlueGradientButton
```dart
BlueGradientButton(
  title: "Confirm Payment",
  onTap: () => _handlePayment(),
)
```

#### Header
```dart
Header(
  color: AppColors.grayBlue,
  avatarOnTap: () => openMyAccountScreen(context),
  faqOnTap: () => openGuidePage(context),
)
```

#### StepContainer
```dart
StepContainer(
  iconPath: Assets.icons.simIcon.path,
  stepNum: "1",
  description: "Insert your eSIM",
)
```

### Components (`lib/components/widgets/`)

#### HelveticaNeueFont
```dart
HelveticaNeueFont(
  text: "Welcome to FlexTravelSIM",
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: AppColors.textPrimary,
)
```

## 🧭 Navigation System

### Route Configuration

| Route                    | Name                | Description           |
|--------------------------|--------------------|-----------------------|
| `/`                      | welcome            | Welcome screen        |
| `/auth`                  | auth               | Authentication        |
| `/initial`               | initial            | Initial setup         |
| `/main-flow`             | mainFlow           | Main dashboard        |
| `/esim-setup`            | esimSetup          | eSIM setup guide      |
| `/top-up-balance`        | topUpBalance       | Balance top-up        |
| `/my-account`            | myAccount          | User profile          |
| `/settings`              | settings           | App settings          |
| `/tariffs-and-countries` | tariffsAndCountries| Plans & destinations  |

### Navigation Utils
```dart
// Type-safe navigation helpers
void openMainFlowScreen(BuildContext context) {
  context.goNamed(AppRoutes.mainFlowName);
}

void openEsimSetupPage(BuildContext context) {
  context.pushNamed(AppRoutes.esimSetupName);
}
```

### Route Guards
```dart
class RouteGuard {
  static String? redirectLogic(GoRouterState state) {
    // Implement authentication checks
    // Redirect logic based on user state
    return null; // Allow navigation
  }
}
```

## 🎨 Design System

### Colors (`lib/constants/app_colors.dart`)

```dart
class AppColors {
  // Primary Colors
  static const primaryColor = Color(0xFF33899E);
  static const secondaryColor = Color(0xFFD54444);
  
  // Background Colors
  static const backgroundColorLight = Color(0xFFFFFFFF);
  static const backgroundColorDark = Color(0xFF000000);
  
  // Text Colors
  static const textColorDark = Color(0xFF000000);
  static const grayBlue = Color(0xFF363C45);
  
  // Gradients
  static const containerGradientPrimary = LinearGradient(
    colors: [Color(0xFF2875FF), Color(0xFF0059F9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

### Typography

**Font Family:** Helvetica Neue
- **Regular (400)** - Body text, labels
- **Medium (500)** - Subheadings, buttons  
- **Bold (700)** - Headings, emphasis

### Assets Management

Type-safe assets via `flutter_gen`:

```dart
// SVG Icons
Assets.icons.mainIcon.svg(
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
)

// Images
Assets.images.logo.image(
  width: 200,
  height: 100,
)

// Usage in widgets
SvgPicture.asset(
  Assets.icons.avatarIcon.path,
  color: AppColors.primaryColor,
)
```

## 🔄 State Management

### BLoC Pattern Implementation

```dart
// Events
abstract class EsimEvent extends Equatable {}

class LoadEsimsEvent extends EsimEvent {
  final bool forceRefresh;
  const LoadEsimsEvent({this.forceRefresh = false});
}

// States  
abstract class EsimState extends Equatable {}

class EsimLoading extends EsimState {}

class EsimLoaded extends EsimState {
  final List<Esim> esims;
  const EsimLoaded(this.esims);
}

class EsimError extends EsimState {
  final String message;
  const EsimError({required this.message});
}

// Bloc
class EsimBloc extends Bloc<EsimEvent, EsimState> {
  final GetEsimsUseCase getEsimsUseCase;
  
  EsimBloc({required this.getEsimsUseCase}) : super(EsimInitial()) {
    on<LoadEsimsEvent>(_onLoadEsims);
  }
}
```

### Provider Setup

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => WelcomeCubit()),
    BlocProvider(create: (_) => MainFlowBloc()),
    BlocProvider(
      create: (_) => EsimBloc(
        getEsimsUseCase: sl(),
        activateEsimUseCase: sl(),
        purchaseEsimUseCase: sl(),
      ),
    ),
    BlocProvider(
      create: (_) => UserBloc(
        getCurrentUserUseCase: sl(),
        updateUserProfileUseCase: sl(),
      ),
    ),
  ],
  child: MaterialApp.router(
    routerConfig: AppRouter.router,
  ),
)
```

## 🔧 Dependency Injection

### Service Locator Pattern

```dart
// Registration
Future<void> init() async {
  // Core
  sl.register<ApiClient>(
    ApiClient(baseUrl: 'https://your-api-domain.com/api/v1'),
  );
  sl.register<LocalStorage>(SharedPreferencesStorage());
  
  // Repositories
  sl.register<EsimRepository>(
    EsimRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  // Use Cases
  sl.register<GetEsimsUseCase>(GetEsimsUseCase(sl()));
}

// Usage
final repository = sl.get<EsimRepository>();
```

## 🚀 Development Setup

### Requirements
- **Flutter SDK:** ≥ 3.7.2
- **Dart SDK:** ≥ 3.0.0
- **Android Studio** or **VS Code**
- **Git**

### Installation

```bash
# Clone repository
git clone <repository-url>
cd flex_travel_sim

# Install dependencies
flutter pub get

# Generate code
flutter packages pub run build_runner build

# Run application
flutter run
```

### Configuration

#### API Configuration
Update the API base URL in `lib/core/di/injection_container.dart`:

```dart
register<ApiClient>(
  ApiClient(
    baseUrl: 'https://your-api-domain.com/api/v1', // 🔧 Your API URL
    client: get<http.Client>(),
  ),
);
```

#### Environment Setup
Create environment-specific configurations:

```dart
class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://staging-api.flextravelsim.com/v1',
  );
}
```

## 📱 Build and Deployment

### Android Build

```bash
# Debug APK
flutter build apk --debug

# Release APK  
flutter build apk --release

# App Bundle for Google Play
flutter build appbundle --release
```

### iOS Build

```bash
# iOS Simulator
flutter build ios --simulator

# iOS Device (Release)
flutter build ios --release
```

### Web Build

```bash
# Web Release
flutter build web --release
```

## 🧪 Testing Strategy

### Unit Tests

```dart
// Test Use Cases
void main() {
  late GetEsimsUseCase useCase;
  late MockEsimRepository mockRepository;
  
  setUp(() {
    mockRepository = MockEsimRepository();
    useCase = GetEsimsUseCase(mockRepository);
  });
  
  group('GetEsimsUseCase', () {
    test('should return esims from repository', () async {
      // arrange
      final tEsims = [Esim(id: '1', name: 'Test eSIM')];
      when(mockRepository.getEsims()).thenAnswer((_) async => Right(tEsims));
      
      // act
      final result = await useCase();
      
      // assert
      expect(result, Right(tEsims));
      verify(mockRepository.getEsims());
    });
  });
}
```

### Widget Tests

```dart
void main() {
  testWidgets('EsimBloc displays loading indicator', (tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => MockEsimBloc(),
        child: MaterialApp(home: EsimScreen()),
      ),
    );
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

### Integration Tests

```bash
# Run integration tests
flutter test integration_test/
```

## 📊 Performance Optimization

### Caching Strategy
- **Automatic caching** of API responses
- **TTL-based cache invalidation** (30 minutes default)
- **Offline-first** approach with graceful fallbacks

### Memory Management
- **Dispose pattern** for BLoCs and controllers
- **Image caching** with flutter_svg
- **Lazy loading** of heavy resources

### Network Optimization
- **Request debouncing** for search queries
- **Retry logic** with exponential backoff
- **Connection state awareness**

## 🔍 Debugging and Monitoring

### Logging

```dart
import 'dart:developer' as developer;

// Structured logging
developer.log(
  'API request failed',
  name: 'FlexTravelSIM.Network',
  error: exception,
  stackTrace: stackTrace,
);
```

### Error Tracking

```dart
// Centralized error reporting
class ErrorReporter {
  static void reportError(dynamic error, StackTrace stackTrace) {
    // Send to Crashlytics/Sentry
    developer.log('Error: $error', stackTrace: stackTrace);
  }
}
```

### Performance Monitoring

```bash
# Profile mode
flutter run --profile

# Performance overlay
flutter run --enable-software-rendering
```

## 🚀 Future Roadmap

### Phase 1: Core Stability
- [x] ✅ **Complete Data Layer** - Clean Architecture implementation
- [x] ✅ **Offline Support** - Caching and offline-first approach
- [ ] **Comprehensive Testing** - 80%+ code coverage
- [ ] **CI/CD Pipeline** - Automated builds and deployments

### Phase 2: Advanced Features
- [ ] **Real-time Updates** - WebSocket integration
- [ ] **Push Notifications** - Firebase Cloud Messaging
- [ ] **Analytics** - User behavior tracking
- [ ] **A/B Testing** - Feature flag system

### Phase 3: Scale & Performance
- [ ] **Micro-frontend Architecture** - Module federation
- [ ] **Advanced Caching** - Redis integration
- [ ] **Performance Monitoring** - Real-time metrics
- [ ] **Internationalization** - Multi-language support

### Phase 4: Enterprise Features
- [ ] **SSO Integration** - Enterprise authentication
- [ ] **Advanced Security** - Biometric authentication
- [ ] **Compliance** - GDPR, CCPA support
- [ ] **White-label Solution** - Customizable branding

## 📚 Additional Resources

### Architecture References
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/#/architecture)
- [Repository Pattern in Flutter](https://medium.com/flutter-community/repository-pattern-in-flutter-78ce8290c506)

### Flutter Resources
- [Flutter Official Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

### Development Tools
- [Flutter Inspector](https://docs.flutter.dev/development/tools/flutter-inspector)
- [Dart DevTools](https://dart.dev/tools/dart-devtools)
- [Flutter Gen](https://pub.dev/packages/flutter_gen)

---

**FlexTravelSIM** - Built with ❤️ using Flutter and Clean Architecture principles.

*Last updated: December 2024*