# FlexTravelSIM Navigation System

This project uses **GoRouter** for navigation, replacing the previous manual Navigator implementation.

## 🚀 Quick Start

### Basic Navigation

```dart
import 'package:flex_travel_sim/utils/navigation_utils.dart';

// Using the NavigationService
NavigationService.openMainFlowScreen(context);
NavigationService.openMyAccountScreen(context);
NavigationService.pop(context);

// Or using legacy function aliases (for backward compatibility)
openMainFlowScreen(context);
openMyAccountScreen(context);
```

### Using GoRouter Extensions

```dart
import 'package:flex_travel_sim/core/router/router_extensions.dart';

// Direct context extensions
context.pushTo('/main-flow');
context.navigateTo('/welcome');
context.goBack();
```

## 📁 File Structure

```
lib/core/router/
├── app_router.dart          # Main router configuration
├── route_guard.dart         # Authentication and route protection
├── router_extensions.dart   # Convenient context extensions
├── navigation_test.dart     # Test widget for navigation
└── README.md               # This documentation
```

## 🛣️ Available Routes

| Route Name | Path | Description |
|------------|------|-------------|
| `welcome` | `/` | Welcome/Onboarding screen |
| `auth` | `/auth` | Authentication screen |
| `initial` | `/initial` | Initial page |
| `mainFlow` | `/main-flow` | Main dashboard |
| `esimSetup` | `/esim-setup` | eSIM setup page |
| `settingEsim` | `/setting-esim` | eSIM settings |
| `activatedEsim` | `/activated-esim` | Activated eSIM screen |
| `topUpBalance` | `/top-up-balance` | Balance top-up |
| `myAccount` | `/my-account` | User account |
| `guide` | `/guide` | Guide/FAQ page |
| `tariffsAndCountries` | `/tariffs-and-countries` | Tariffs & countries |
| `settings` | `/settings` | App settings |
| `purchaseHistory` | `/purchase-history` | Purchase history |
| `trafficUsage` | `/traffic-usage` | Traffic usage stats |
| `language` | `/language` | Language selection |

## 🔐 Route Protection

The system includes a route guard that can handle:
- Authentication checks
- Onboarding completion
- Route-based permissions

### Protected Routes
- Main Flow
- Top Up Balance
- My Account
- Purchase History
- Traffic Usage
- Settings

### Public Routes
- Welcome
- Auth
- Initial

## 🎨 Navigation Transitions

### No Transition
Used for instant navigation (e.g., tab switches):
```dart
_buildPageWithNoTransition(context, state, widget)
```

### Slide Transition
Used for screen-to-screen navigation with smooth slide effect:
```dart
_buildPageWithSlideTransition(context, state, widget)
```

## 📝 Migration Guide

### Old vs New Navigation

**Before (Manual Navigator):**
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MyScreen(),
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  ),
);
```

**After (GoRouter):**
```dart
NavigationService.openMyScreen(context);
// or
context.pushTo('/my-screen');
```

### Backward Compatibility

All existing navigation functions are still available as legacy aliases:
- `openMainFlowScreen(context)`
- `openMyAccountScreen(context)`
- `openTopUpBalanceScreen(context)`
- etc.

## 🔧 Adding New Routes

1. **Add route constants to `AppRoutes`:**
```dart
static const String newScreen = '/new-screen';
static const String newScreenName = 'newScreen';
```

2. **Add route definition to `AppRouter.router`:**
```dart
GoRoute(
  path: AppRoutes.newScreen,
  name: AppRoutes.newScreenName,
  pageBuilder: (context, state) => _buildPageWithSlideTransition(
    context,
    state,
    const NewScreen(),
  ),
),
```

3. **Add navigation method to `NavigationService`:**
```dart
static void openNewScreen(BuildContext context) {
  context.push(AppRoutes.newScreen);
}
```

4. **Add legacy alias (optional):**
```dart
void openNewScreen(BuildContext context) => NavigationService.openNewScreen(context);
```

## 🧪 Testing Navigation

Use the `NavigationTestWidget` to test all navigation routes:

```dart
import 'package:flex_travel_sim/core/router/navigation_test.dart';

// In your debug/test environment
MaterialApp(
  home: NavigationTestWidget(),
)
```

## 🚨 Common Issues

### 1. Context Issues
Make sure you're using the correct BuildContext when navigating:
```dart
// ✅ Good
Navigator.of(context).push(...);

// ❌ Bad - using wrong context
Navigator.of(globalContext).push(...);
```

### 2. Route Not Found
Ensure all routes are properly defined in `AppRouter` and paths match exactly.

### 3. Transition Issues
If transitions aren't working, check that you're using the correct page builder function.

## 🔮 Future Enhancements

- [ ] Deep linking support
- [ ] Route parameters and query strings
- [ ] Nested navigation
- [ ] Route-based state management
- [ ] Analytics integration
- [ ] Error handling for invalid routes
