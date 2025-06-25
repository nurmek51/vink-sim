#!/bin/bash

# Скрипт для настройки iOS подписания Flutter проекта
# для команды FLEX GLOBAL ECOSYSTEM

echo "🔧 Настройка iOS подписания для FlexTravelSIM..."

# Перейдем в корень проекта
cd "$(dirname "$0")/.."

# Проверим, что мы в правильной директории
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Ошибка: запустите скрипт из корня Flutter проекта"
    exit 1
fi

# Очистим билд кэш
echo "🧹 Очистка билд кэша..."
flutter clean

# Получим зависимости
echo "📦 Получение зависимостей..."
flutter pub get

# Установим CocoaPods зависимости
echo "🍫 Установка CocoaPods зависимостей..."
cd ios
pod install
cd ..

# Информация о настройках
echo ""
echo "✅ Настройка завершена!"
echo ""
echo "📋 Текущие настройки:"
echo "   • Bundle ID: com.flextraversim"
echo "   • Team ID: P4YWHA27ZC (FLEX GLOBAL ECOSYSTEM - FZCO)"
echo "   • Signing: Automatic"
echo ""
echo "🎯 Следующие шаги:"
echo "   1. Откройте Xcode: open ios/Runner.xcworkspace"
echo "   2. Убедитесь, что ваш Apple ID добавлен в Xcode → Preferences → Accounts"
echo "   3. Выберите команду 'FLEX GLOBAL ECOSYSTEM - FZCO' в Signing & Capabilities"
echo "   4. Запустите на устройстве: flutter run"
echo ""
echo "🚀 Для TestFlight: flutter build ipa"
echo ""
