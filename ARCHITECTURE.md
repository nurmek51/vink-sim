# Vink Architecture & Feature Module Strategy

## 1. Overview

Vink is a super-app ecosystem composed of:
1.  **Vink (Main App)**: The primary application shell (Wallet).
2.  **Vink Sim (Feature Module)**: A standalone e-sim feature that can be embedded into Vink.

## 2. Architecture Principles

We follow a **Shared Feature Module Architecture** where the feature module (`vink-sim`) is a Git dependency of the main app (`vink`).

### Key Rules:
*   **Zero Knowledge**: The Feature Module has NO knowledge of the Main App.
*   **Single Entry Point**: The Feature Module exposes ONLY `feature_app.dart` (exporting `FeatureRoot` and `FeatureConfig`).
*   **Configuration Injection**: All external dependencies (API, Navigation callbacks) are injected via `FeatureConfig`.
*   **Strict Versioning**: Updates are propagated via Git Tags (Semantic Versioning).

## 3. Repository Structure

### 3.1 Feature Module (`vink-sim`)
Contains all business logic, UI, and navigation for the e-sim feature.

```
vink-sim/
├── lib/
│   ├── api/
│   ├── config/          # FeatureConfig definition
│   ├── di/
│   ├── navigation/      # Internal scoped router
│   ├── ui/              # FeatureRoot widget
│   ├── state/
│   └── vink_sim.dart    # PUBLIC ENTRY POINT
├── example/             # Standalone runner
├── pubspec.yaml
└── README.md
```

### 3.2 Main App (`vink`)
The application shell that hosts the feature.

```
vink/
├── lib/
│   ├── app/             # VinkApp (Root Widget)
│   ├── shell_navigation/# ShellRouter (App-level routing)
│   ├── features/        # Native Vink features (Wallet, etc.)
│   └── main.dart        # Entry point
└── pubspec.yaml
```

## 4. Integration Contract

### FeatureRoot
The Feature Module exposes a `FeatureRoot` widget, NOT a `MaterialApp`.

```dart
class FeatureRoot extends StatelessWidget {
  final FeatureConfig config;
  // ...
}
```

### FeatureConfig
Dependencies are injected via config.

```dart
class FeatureConfig {
  final String apiBaseUrl;
  final VoidCallback onExit;
  // ...
}
```

## 5. Release Workflow

1.  **Develop**: Make changes in `vink-sim`.
2.  **Test**: Run `vink-sim/example` to verify standalone behavior.
3.  **Tag**: Bump version in `pubspec.yaml` and create a Git Tag (e.g., `v1.2.0`).
4.  **Update Shell**: In `vink/pubspec.yaml`, update the git dependency ref:

```yaml
dependencies:
  vink_sim:
    git:
      url: https://github.com/org/vink-sim.git
      ref: v1.2.0
```

## 6. Navigation

*   **Shell App**: Uses `GoRouter` (ShellRouter) to navigate between main tabs/screens.
*   **Feature Module**: Uses its own internal scoped `GoRouter` or `Navigator`.
*   **Deep Linking**: The Shell App handles deep links and routes them to the Feature Module via the `FeatureConfig` or initial route parameters if supported.

## 7. State Management

*   **Shell**: Riverpod/Bloc.
*   **Feature**: Riverpod/Bloc (Scoped).
*   **Sharing**: NO shared global state. Data is passed via `FeatureConfig` or API.

## 8. Onboarding

### For Vink Developers
1.  Clone `vink`.
2.  `flutter pub get`.
3.  Run `lib/main.dart`.

### For Vink Sim Developers
1.  Clone `vink-sim`.
2.  `flutter pub get`.
3.  Run `example/lib/main.dart` to develop in isolation.
