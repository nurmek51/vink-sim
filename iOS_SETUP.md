# iOS Setup для FlexTravelSIM

## Автоматическая настройка

Запустите скрипт автоматической настройки:

```bash
./scripts/setup_ios_signing.sh
```

## Ручная настройка

### 1. Настройка в Xcode

1. Откройте проект в Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Добавьте ваш Apple ID:
   - **Xcode** → **Preferences** → **Accounts**
   - Нажмите **"+"** → **Apple ID**
   - Введите ваш Apple ID и пароль

3. Настройте подписание:
   - Выберите проект **Runner** в навигаторе
   - Выберите Target **Runner**
   - Перейдите на вкладку **"Signing & Capabilities"**
   - **Team**: выберите **"FLEX GLOBAL ECOSYSTEM - FZCO (P4YWHA27ZC)"**
   - Поставьте галочку **"Automatically manage signing"**

### 2. Текущие настройки проекта

- ✅ **Bundle Identifier**: `com.flextraversim`
- ✅ **Development Team**: `P4YWHA27ZC` (FLEX GLOBAL ECOSYSTEM - FZCO)
- ✅ **Signing**: Automatic

### 3. Запуск на устройстве

```bash
# Запуск в debug режиме
flutter run

# Запуск на конкретном устройстве
flutter run -d "iPhone"

# Сборка для release
flutter build ios --release
```

### 4. TestFlight/App Store

```bash
# Создание IPA файла для TestFlight
flutter build ipa

# Файл будет сохранён в: build/ios/ipa/FlexTravelSIM.ipa
```

## Troubleshooting

### Ошибка "Bundle identifier is missing"
Убедитесь, что Bundle ID установлен в проекте: `com.flextraversim`

### Ошибка "Signing for Runner requires a development team"
1. Добавьте Apple ID в Xcode Preferences → Accounts
2. Выберите команду FLEX GLOBAL ECOSYSTEM в настройках подписания

### Ошибка "Communication with Apple failed"
1. Подключите физическое устройство через USB
2. Или используйте симулятор для тестирования

### Проблемы с сертификатами
Убедитесь, что ваш Apple ID имеет доступ к команде разработчиков FLEX GLOBAL ECOSYSTEM.

## Полезные команды

```bash
# Очистка проекта
flutter clean

# Обновление зависимостей
flutter pub get

# Установка CocoaPods
cd ios && pod install

# Проверка доступных устройств
flutter devices

# Проверка сертификатов
security find-identity -v -p codesigning
```

## Структура iOS проекта

```
ios/
├── Runner.xcworkspace          # Главный файл проекта
├── Runner.xcodeproj/          # Настройки проекта
├── Runner/
│   ├── Info.plist            # Метаданные приложения
│   ├── AppDelegate.swift     # Точка входа iOS
│   └── Assets.xcassets       # Ресурсы (иконки, изображения)
├── Podfile                   # CocoaPods зависимости
└── Pods/                     # Установленные pods
```

---

**Команда разработки FLEX GLOBAL ECOSYSTEM**
- Team ID: P4YWHA27ZC
- Apple Developer Program до: May 24, 2026
- Annual fee: AED379
