# 📱 FlexTravelSIM

> **Modern eSIM Management Application**  
> Seamless travel connectivity with instant eSIM activation

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.7.2-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-11.x-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android%20%7C%20Web-lightgrey.svg)
![License](https://img.shields.io/badge/license-Private-red.svg)

</div>

## 🚀 Overview

**FlexTravelSIM** is a cross-platform mobile application built with Flutter that revolutionizes how travelers manage their mobile connectivity. The app provides instant eSIM purchasing, activation, and management with support for multiple carriers worldwide.

### ✨ Key Features

- 🌍 **Global eSIM Coverage** - 200+ countries and territories
- ⚡ **Instant Activation** - QR code and manual setup options
- 💳 **Secure Payments** - Stripe integration with Apple/Google Pay
- 📊 **Usage Analytics** - Real-time data consumption tracking  
- 🔐 **Multi-factor Authentication** - SMS and Firebase Auth
- 🎨 **Modern UI/UX** - Intuitive design with dark mode support
- 🌐 **Multi-platform** - iOS, Android, and Web support

## 📋 Table of Contents

- [🚀 Overview](#-overview)
- [🛠 Tech Stack](#-tech-stack)
- [📱 Screenshots](#-screenshots)
- [🔧 Installation](#-installation)
- [⚙️ Configuration](#️-configuration)
- [🏗 Architecture](#-architecture)
- [📖 API Documentation](#-api-documentation)
- [🧪 Testing](#-testing)
- [🚀 Deployment](#-deployment)
- [🤝 Contributing](#-contributing)

## 🛠 Tech Stack

### Frontend
- **Flutter 3.7.2** - Cross-platform framework
- **Dart** - Programming language
- **BLoC Pattern** - State management
- **GoRouter** - Navigation management
- **Easy Localization** - Internationalization

### Backend & Services
- **Firebase** - Authentication, Analytics, Crashlytics
- **Google Cloud Run** - API hosting
- **Stripe** - Payment processing
- **REST API** - Backend communication

### Development & Tools
- **Clean Architecture** - Scalable project structure
- **Dependency Injection** - Service management
- **Environment Configuration** - Multi-stage deployment
- **Automated Testing** - Unit, Widget, Integration tests

## 📱 Screenshots

<div align="center">
  <img src="assets/screenshots/onboarding.png" width="200" alt="Onboarding" />
  <img src="assets/screenshots/dashboard.png" width="200" alt="Dashboard" />
  <img src="assets/screenshots/esim-setup.png" width="200" alt="eSIM Setup" />
  <img src="assets/screenshots/payment.png" width="200" alt="Payment" />
</div>

## 🔧 Installation

### Prerequisites

- **Flutter SDK** ≥ 3.7.2
- **Dart SDK** ≥ 3.7.2  
- **Xcode** ≥ 14.0 (for iOS)
- **Android Studio** (for Android)
- **Firebase CLI** (for deployment)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/flexunion/flex-travel-sim.git
cd flex-travel-sim

# Install dependencies
flutter pub get

# Set up environment variables
cp .env.development.template .env.development
cp .env.production.template .env.production

# Run the app
flutter run
```

## ⚙️ Configuration

### Environment Variables

The app uses environment-specific configuration files:

```bash
.env.development    # Development environment
.env.production     # Production environment
```

#### Required Variables

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY_WEB=your-web-key
FIREBASE_API_KEY_ANDROID=your-android-key
FIREBASE_API_KEY_IOS=your-ios-key

# API Configuration
API_URL=https://your-api.com

# Stripe Configuration
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
```

### Firebase Setup

1. **Create Firebase Project** in [Firebase Console](https://console.firebase.google.com)
2. **Enable Authentication** with Phone provider
3. **Add Apps** for iOS, Android, and Web
4. **Download Configuration Files**:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

### iOS Configuration

1. **Open Xcode**: `open ios/Runner.xcworkspace`
2. **Set Team** in Signing & Capabilities
3. **Configure Bundle ID**: `com.flexunion.FlexSim`
4. **Add Capabilities**: Associated Domains, Push Notifications

Detailed iOS setup: [iOS_SETUP.md](iOS_SETUP.md)

### Android Configuration

1. **Set Package Name**: `com.example.flex_travel_sim`
2. **Configure Signing**: Add release keystore
3. **Update Permissions** in AndroidManifest.xml

## 🏗 Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities and services
│   ├── config/             # Environment configuration  
│   ├── network/            # API clients and interceptors
│   ├── router/             # Navigation setup
│   └── services/           # Shared services
├── features/               # Feature modules
│   ├── auth/               # Authentication
│   ├── dashboard/          # Main dashboard
│   ├── esim_management/    # eSIM operations
│   └── stripe_payment/     # Payment processing
└── shared/                 # Shared UI components
```

**Key Patterns:**
- **Repository Pattern** - Data layer abstraction
- **BLoC Pattern** - Reactive state management  
- **Dependency Injection** - Service locator
- **Either Pattern** - Functional error handling

Detailed architecture: [documentation.md](documentation.md)

## 📖 API Documentation

### Base URL
- **Production**: `https://api-qaoayxzmga-uc.a.run.app`
- **Development**: `https://api-q23aq227oa-uc.a.run.app`

### Key Endpoints

```http
POST /otp/whatsapp          # Send OTP via WhatsApp
POST /otp/verify            # Verify OTP code
GET  /subscriber            # Get user profile
GET  /tariffs               # Get available plans
POST /esim/purchase         # Purchase eSIM
```

## 🧪 Testing

### Running Tests

```bash
# Unit tests
flutter test

# Widget tests  
flutter test test/widget_test/

# Integration tests
flutter test integration_test/
```

### Test Coverage

```bash
# Generate coverage report
flutter test --coverage
lcov --summary coverage/lcov.info
```

## 🚀 Deployment

### Development Build
```bash
./scripts/build-development.sh
```

### Production Build  
```bash
./scripts/build-production.sh
```

### App Store Deployment
```bash
# iOS App Store
flutter build ios --release
open ios/Runner.xcworkspace
# Archive → Distribute App

# Google Play Store  
flutter build appbundle --release
# Upload to Google Play Console
```

### Web Deployment
```bash
./scripts/build-web.sh
firebase deploy --only hosting
```

## 🤝 Contributing

This is a private project. For access and contribution guidelines, please contact the development team.

### Development Workflow

1. **Create Feature Branch**: `git checkout -b feature/new-feature`
2. **Follow Coding Standards**: Use provided linting rules
3. **Write Tests**: Ensure adequate test coverage
4. **Update Documentation**: Keep docs synchronized
5. **Create Pull Request**: Include detailed description

### Code Style

- **Dart Style Guide**: Follow official Dart conventions
- **Flutter Best Practices**: Implement recommended patterns
- **Clean Architecture**: Maintain layer separation
- **Meaningful Names**: Use descriptive variable/function names

---

## 📄 Additional Documentation

- [📖 Detailed Architecture](documentation.md)
- [🌐 Web Firebase Setup](README-Web-Firebase.md)
- [🍎 iOS Configuration](iOS_SETUP.md)
- [🔧 Core Documentation](lib/core/README.md)

## 📞 Support

For technical issues and feature requests, please contact the development team.

---

<div align="center">

**Built with ❤️ by FlexUnion Team**

*Connecting the world, one eSIM at a time*

</div>