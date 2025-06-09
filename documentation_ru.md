# FlexTravelSIM - Документация проекта

### Паттерны проектирования
- **BLoC Pattern** - для управления состоянием
- **Feature-based Architecture** - модульная структура
- **Repository Pattern** - для работы с данными
- **Dependency Injection** - для внедрения зависимостей

### Структура проекта

```
lib/
├── core/                    # Базовые компоненты
│   ├── di/                 # Dependency Injection
│   ├── error/              # Обработка ошибок
│   ├── router/             # Навигация
│   ├── styles/             # Стили приложения
│   └── usecases/           # Use Cases
├── features/               # Модули приложения
│   ├── authentication/     # Аутентификация
│   ├── dashboard/          # Главный экран
│   ├── onboarding/         # Введение в приложение
│   ├── esim_management/    # Управление eSIM
│   ├── balance_management/ # Управление балансом
│   ├── settings/           # Настройки
│   └── ...
├── shared/                 # Переиспользуемые компоненты
│   └── widgets/            # Общие виджеты
├── components/             # UI компоненты
│   └── widgets/            # Базовые виджеты
├── constants/              # Константы
├── utils/                  # Утилиты
└── gen/                   # Сгенерированные файлы
```

## Технологический стек

### Основные зависимости

| Пакет          | Версия  | Назначение            |
| -------------- | ------- | --------------------- |
| `flutter_bloc` | ^8.1.6  | Управление состоянием |
| `go_router`    | ^14.6.2 | Навигация             |
| `flutter_svg`  | ^2.1.0  | Работа с SVG          |
| `http`         | ^1.4.0  | HTTP запросы          |
| `equatable`    | ^2.0.5  | Сравнение объектов    |

### Инструменты разработки
- **Flutter Gen** - генерация типизированных ассетов
- **Flutter Lints** - анализ кода
- **BLoC Test** - тестирование BLoC компонентов

## Модули приложения

### 1. Authentication (`lib/features/authentication/`)
**Назначение:** Аутентификация пользователей через номер телефона

**Компоненты:**
- `AuthScreen` - экран ввода номера телефона
- `MobileNumberField` - поле ввода номера
- `RegistrationContainer` - контейнер регистрации

### 2. Onboarding (`lib/features/onboarding/`)
**Назначение:** Знакомство пользователя с приложением

**Компоненты:**
- `WelcomeScreen` - экран приветствия
- `WelcomeCubit` - управление состоянием welcome экрана
- `ResendCodeTimerCubit` - таймер для повторной отправки кода

### 3. Dashboard (`lib/features/dashboard/`)
**Назначение:** Главный экран с информацией об eSIM и трафике

**Компоненты:**
- `MainFlowScreen` - основной экран
- `MainFlowBloc` - управление состоянием главного экрана
- `PercentageWidget` - виджет отображения процентов
- `ChatContainer` - контейнер чата поддержки

### 4. eSIM Management (`lib/features/esim_management/`)
**Назначение:** Управление eSIM картами

**Компоненты:**
- `EsimSetupPage` - страница настройки eSIM
- `EsimSetupCubit` - управление состоянием настройки

### 5. Balance Management (`lib/features/balance_management/`)
**Назначение:** Пополнение и управление балансом

**Компоненты:**
- `TopUpBalanceScreen` - экран пополнения баланса
- `TopUpBalanceCubit` - управление состоянием пополнения
- `PaymentTypeSelector` - выбор способа оплаты

### 6. Settings (`lib/features/settings/`)
**Назначение:** Настройки приложения и профиля

**Компоненты:**
- `SettingsScreen` - экран настроек
- `PurchaseHistoryScreen` - история покупок
- `LanguageScreen` - выбор языка

## UI/UX Компоненты

### Shared Widgets (`lib/shared/widgets/`)

#### BlueGradientButton
```dart
BlueGradientButton(
  title: "Подтвердить",
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
  description: "Описание шага",
)
```

### Components (`lib/components/widgets/`)

#### HelveticaneueFont
Кастомный текстовый виджет с шрифтом Helvetica Neue:
```dart
HelveticaneueFont(
  text: "Текст",
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
)
```

## Навигация

### Маршруты приложения

| Маршрут           | Название     | Описание           |
| ----------------- | ------------ | ------------------ |
| `/`               | welcome      | Экран приветствия  |
| `/auth`           | auth         | Аутентификация     |
| `/initial`        | initial      | Начальный экран    |
| `/main-flow`      | mainFlow     | Главный экран      |
| `/esim-setup`     | esimSetup    | Настройка eSIM     |
| `/top-up-balance` | topUpBalance | Пополнение баланса |
| `/settings`       | settings     | Настройки          |

### Переходы между экранами

```dart
// Переход на главный экран
context.goNamed(AppRoutes.mainFlowName);

// Переход с параметрами
context.pushNamed(
  AppRoutes.esimSetupName,
  extra: {'esimId': esimId},
);
```

## Дизайн система

### Цвета (`lib/constants/app_colors.dart`)

```dart
class AppColors {
  static const containerGradientPrimary = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
  );
  
  static const backgroundPrimary = Color(0xFFF8F9FA);
  static const textPrimary = Color(0xFF363C45);
}
```

### Шрифты

**Семейство:** Helvetica Neue
- Regular (400) - основной текст
- Medium (500) - подзаголовки
- Bold (700) - заголовки

### Ассеты

Все ассеты типизированы через `flutter_gen`:

```dart
// Иконки
Assets.icons.mainIcon.svg()
Assets.icons.avatarIcon.svg()
Assets.icons.simIcon.svg()

// Использование в коде
SvgPicture.asset(Assets.icons.mainIcon.path)
```

## Управление состоянием

### BLoC Pattern

Приложение использует BLoC для управления состоянием:

```dart
// Cubit для простых состояний
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());
  
  void nextStep() {
    emit(WelcomeNextStep());
  }
}

// Bloc для сложной логики
class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(MainFlowInitial()) {
    on<LoadTrafficData>(_onLoadTrafficData);
  }
}
```

### Провайдеры

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => WelcomeCubit()),
    BlocProvider(create: (_) => MainFlowBloc()),
  ],
  child: MaterialApp.router(...),
)
```

## Запуск и разработка

### Требования
- Flutter SDK ≥ 3.7.2
- Dart SDK ≥ 3.0.0
- Android Studio / VS Code
- Git

### Установка и запуск

```bash
# Клонирование репозитория
git clone <repository-url>
cd flex_travel_sim

# Установка зависимостей
flutter pub get

# Генерация ассетов
flutter packages pub run build_runner build

# Запуск на эмуляторе
flutter run

# Сборка для релиза
flutter build apk --release
```

## 📱 Сборка и развертывание

### Android

```bash
# Debug сборка
flutter build apk --debug

# Release сборка
flutter build apk --release

# App Bundle для Google Play
flutter build appbundle --release
```

### iOS

```bash
# Сборка для симулятора
flutter build ios --simulator

# Сборка для устройства
flutter build ios --release
```

### Web

```bash
# Сборка для веб
flutter build web --release
```

## Конфигурация

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

## Отладка и профилирование

### Flutter Inspector
Используйте Flutter Inspector для анализа виджетов:
```bash
flutter inspector
```

### Performance
Профилирование производительности:
```bash
flutter run --profile
```

### Логирование
```dart
import 'dart:developer' as developer;

developer.log('Debug message', name: 'FlexTravelSIM');
```

## TODO и планы развития

### Краткосрочные задачи
- [x] ~~Исправить импорты в `app_router.dart`~~ ✅ **Выполнено**
- [ ] Добавить unit тесты для Cubit'ов
- [ ] Настроить CI/CD pipeline
- [ ] Добавить локализацию

### Долгосрочные планы
- [ ] Интеграция с реальным API
- [ ] Push уведомления
- [ ] Аналитика и метрики
- [ ] Темная тема
- [ ] Offline режим
