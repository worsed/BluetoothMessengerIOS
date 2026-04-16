# Как создать IPA файл для установки

IPA файл - это установочный пакет iOS приложения, который можно установить на iPhone без Xcode.

## Способ 1: Через Xcode (рекомендуется)

### Шаги:

1. **Откройте проект в Xcode**
   ```bash
   open BluetoothMessengerIOS.xcodeproj
   ```

2. **Выберите Generic iOS Device**
   - Product → Destination → Any iOS Device (arm64)

3. **Создайте архив**
   - Product → Archive
   - Дождитесь завершения (1-5 минут)

4. **Экспортируйте IPA**
   - Откроется окно Organizer
   - Выберите созданный архив
   - Нажмите "Distribute App"
   - Выберите "Custom"
   - Next
   - Выберите "Development" (для личного использования) или "Ad Hoc" (для распространения)
   - Next
   - App Thinning: None
   - Rebuild from Bitcode: снимите галочку
   - Next → Export
   - Выберите папку для сохранения

5. **Получите IPA**
   - В выбранной папке найдите файл `BluetoothMessengerIOS.ipa`

## Способ 2: Через командную строку

```bash
# 1. Соберите проект
xcodebuild -project BluetoothMessengerIOS.xcodeproj \
           -scheme BluetoothMessengerIOS \
           -configuration Release \
           -archivePath build/BluetoothMessengerIOS.xcarchive \
           archive

# 2. Экспортируйте IPA
xcodebuild -exportArchive \
           -archivePath build/BluetoothMessengerIOS.xcarchive \
           -exportPath build \
           -exportOptionsPlist ExportOptions.plist
```

Создайте `ExportOptions.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>compileBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <false/>
</dict>
</plist>
```

## Установка IPA на iPhone

### Вариант A: AltStore (без Mac)

1. **Установите AltStore**
   - Скачайте с https://altstore.io
   - Установите AltServer на компьютер
   - Установите AltStore на iPhone

2. **Установите IPA**
   - Откройте AltStore на iPhone
   - My Apps → + (плюс)
   - Выберите файл `.ipa`
   - Дождитесь установки

### Вариант B: Apple Configurator (Mac)

1. **Установите Apple Configurator**
   - Скачайте из Mac App Store

2. **Подключите iPhone**
   - Подключите кабелем к Mac

3. **Установите IPA**
   - Откройте Apple Configurator
   - Выберите iPhone
   - Actions → Add → Apps
   - Выберите файл `.ipa`

### Вариант C: Xcode (Mac)

1. **Откройте Devices and Simulators**
   - Window → Devices and Simulators (⇧⌘2)

2. **Выберите iPhone**
   - Подключите iPhone кабелем
   - Выберите в списке слева

3. **Установите IPA**
   - Нажмите + под "Installed Apps"
   - Выберите файл `.ipa`

### Вариант D: Diawi (онлайн)

1. **Загрузите IPA**
   - Перейдите на https://www.diawi.com
   - Перетащите файл `.ipa`
   - Дождитесь загрузки

2. **Получите ссылку**
   - Скопируйте ссылку

3. **Установите на iPhone**
   - Откройте ссылку в Safari на iPhone
   - Нажмите "Install"
   - Настройки → Основные → VPN и управление устройством → Доверять

## Типы сборок

### Development
- Для личного использования
- Работает только на зарегистрированных устройствах
- Нужен бесплатный Apple ID

### Ad Hoc
- Для распространения тестировщикам
- До 100 устройств
- Нужен платный Apple Developer аккаунт

### Enterprise
- Для внутрикорпоративного распространения
- Неограниченное количество устройств
- Нужен Enterprise аккаунт ($299/год)

### App Store
- Для публичного релиза
- Через App Store Connect
- Нужен платный аккаунт + прохождение ревью

## Размер IPA

Ожидаемый размер: 5-10 MB

Для уменьшения размера:
- Включите App Thinning
- Удалите неиспользуемые ресурсы
- Оптимизируйте изображения

## Проблемы

### "Unable to install"
→ Проверьте что устройство зарегистрировано в provisioning profile

### "Untrusted Developer"
→ Настройки → Основные → VPN и управление устройством → Доверять

### "This app cannot be installed"
→ Проверьте что сборка подписана правильным сертификатом

## Автоматизация

Для CI/CD используйте fastlane:

```ruby
# Fastfile
lane :build_ipa do
  build_app(
    scheme: "BluetoothMessengerIOS",
    export_method: "development"
  )
end
```

Запуск:
```bash
fastlane build_ipa
```
