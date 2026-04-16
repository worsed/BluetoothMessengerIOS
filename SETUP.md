# Инструкция по настройке проекта

## Создание проекта в Xcode

Поскольку файл `.pbxproj` сложно создать вручную, следуйте этим шагам:

### Вариант 1: Создание через Xcode (Рекомендуется)

1. Откройте Xcode
2. File → New → Project
3. Выберите "iOS" → "App"
4. Заполните:
   - Product Name: `BluetoothMessengerIOS`
   - Team: Ваша команда разработчика
   - Organization Identifier: `com.btmessenger`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Storage: `SwiftData`
   - Minimum Deployment: `iOS 18.0`
5. Сохраните проект
6. Замените созданные файлы на файлы из этой папки

### Вариант 2: Использование Package.swift (Альтернатива)

Создайте `Package.swift` в корне папки:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BluetoothMessengerIOS",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "BluetoothMessengerIOS",
            targets: ["BluetoothMessengerIOS"])
    ],
    targets: [
        .target(
            name: "BluetoothMessengerIOS",
            path: ".")
    ]
)
```

Затем откройте через Xcode: File → Open → выберите папку

## Настройка разрешений

В Xcode:

1. Выберите проект в навигаторе
2. Targets → BluetoothMessengerIOS
3. Info → Custom iOS Target Properties
4. Добавьте ключи из `Info.plist`

## Структура проекта

```
BluetoothMessengerIOS/
├── BluetoothMessengerIOSApp.swift    # Точка входа
├── ContentView.swift                  # Главный экран
├── Models/
│   ├── Message.swift                  # Модель сообщения (UI)
│   └── ChatMessage.swift              # Модель для SwiftData
├── ViewModels/
│   └── MessengerViewModel.swift       # Бизнес-логика
├── Views/
│   └── SettingsView.swift             # Экран настроек
├── Services/
│   └── MultipeerService.swift         # Bluetooth/Wi-Fi связь
├── Assets.xcassets/                   # Ресурсы
├── Info.plist                         # Конфигурация
└── README.md                          # Документация
```

## Запуск

1. Подключите iPhone/iPad или используйте симулятор
2. Выберите устройство в Xcode
3. Нажмите Run (⌘R)

## Тестирование

Для полноценного тестирования нужны 2 физических устройства:
- Симулятор не поддерживает MultipeerConnectivity
- Запустите приложение на двух iPhone/iPad
- Устройства автоматически найдут друг друга

## Возможные проблемы

### "Local Network" разрешение
- Первый запуск попросит разрешение на локальную сеть
- Обязательно разрешите для работы приложения

### Устройства не находят друг друга
- Убедитесь что Bluetooth и Wi-Fi включены
- Проверьте что устройства в радиусе 30 метров
- Перезапустите приложение на обоих устройствах

### Ошибки компиляции
- Убедитесь что выбран iOS 18.0+ deployment target
- Проверьте что все файлы добавлены в Target Membership
