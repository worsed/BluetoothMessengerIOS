# 🚀 Быстрый старт (5 минут)

Самый простой способ запустить приложение на вашем iPhone.

## Что нужно:
- ✅ Mac с Xcode
- ✅ iPhone с кабелем
- ✅ Бесплатный Apple ID (ваш обычный iCloud аккаунт)

## Шаги:

### 1. Откройте Xcode
```bash
# Если Xcode не установлен, скачайте из App Store
open -a Xcode
```

### 2. Создайте новый проект
- File → New → Project
- iOS → App
- Product Name: `BluetoothMessengerIOS`
- Interface: SwiftUI
- Storage: SwiftData
- Language: Swift

### 3. Замените файлы
Скопируйте все файлы из папки `BluetoothMessengerIOS` в созданный проект

### 4. Подключите iPhone
- Подключите кабелем к Mac
- Разблокируйте iPhone
- Нажмите "Доверять" на iPhone

### 5. Выберите iPhone в Xcode
В верхней панели Xcode выберите ваш iPhone (не симулятор!)

### 6. Добавьте Apple ID
- Xcode → Settings → Accounts
- Нажмите + → Apple ID
- Войдите с вашим Apple ID

### 7. Настройте подписание
- Выберите проект слева
- Targets → BluetoothMessengerIOS
- Signing & Capabilities
- Team: выберите ваш Apple ID
- Bundle Identifier: измените на `com.ВашеИмя.btmessenger`

### 8. Запустите!
Нажмите кнопку ▶️ (Run) или ⌘R

### 9. Доверьте на iPhone (первый раз)
На iPhone:
- Настройки → Основные → VPN и управление устройством
- Найдите ваш Apple ID
- Нажмите "Доверять [ваш email]"

### 10. Готово! 🎉
Приложение запустится на вашем iPhone

## Для второго iPhone:
Повторите те же шаги на другом Mac или попросите друга установить так же.

## Важно:
- Приложение работает 7 дней, потом нужно переустановить
- Для постоянной установки нужен платный аккаунт ($99/год)
- Для тестирования этого достаточно!

## Проблемы?
Смотрите DEPLOYMENT.md для других способов установки.
