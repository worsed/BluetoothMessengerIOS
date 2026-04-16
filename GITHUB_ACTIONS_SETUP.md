# 🤖 Автоматическая сборка через GitHub Actions

Соберите iOS приложение БЕЗ Mac, используя бесплатные серверы GitHub!

## 📋 Что это дает?

- ✅ Бесплатная сборка на серверах Apple
- ✅ Автоматическая сборка при каждом коммите
- ✅ Скачивание готового IPA файла
- ✅ 2000 минут сборки в месяц бесплатно

## 🚀 Быстрый старт

### 1. Создайте репозиторий на GitHub

```bash
# Инициализируйте git (если еще не сделали)
cd BluetoothMessengerIOS
git init

# Добавьте файлы
git add .
git commit -m "Initial commit"

# Создайте репозиторий на GitHub.com
# Затем подключите его:
git remote add origin https://github.com/ВАШ_USERNAME/BluetoothMessengerIOS.git
git branch -M main
git push -u origin main
```

### 2. Workflow уже настроен!

Файл `.github/workflows/build-ios.yml` уже создан и готов к работе.

### 3. Запустите сборку

**Автоматически:**
- Просто сделайте push в репозиторий
- GitHub Actions автоматически запустит сборку

**Вручную:**
1. Перейдите на GitHub.com в ваш репозиторий
2. Actions → Build iOS App
3. Run workflow → Run workflow
4. Дождитесь завершения (5-10 минут)

### 4. Скачайте результат

1. Перейдите в Actions → выберите завершенную сборку
2. Artifacts → скачайте:
   - `BluetoothMessengerIOS-Archive` - архив проекта
   - `BluetoothMessengerIOS-IPA` - готовый IPA файл (если удалось экспортировать)
   - `BluetoothMessengerIOS-App` - .app файл

### 5. Установите на iPhone

Используйте AltStore или Sideloadly (см. NO_MAC_GUIDE.md)

## 🔧 Настройка подписания (опционально)

Для создания полноценного IPA нужно настроить подписание:

### Шаг 1: Создайте сертификаты

На Mac (или арендованном Mac):
```bash
# Создайте сертификат разработчика
# Keychain Access → Certificate Assistant → Request a Certificate

# Экспортируйте сертификат и приватный ключ
# Keychain Access → My Certificates → Export
```

### Шаг 2: Добавьте секреты в GitHub

1. Settings → Secrets and variables → Actions
2. New repository secret

Добавьте:
- `CERTIFICATE_P12` - Base64 сертификата
- `CERTIFICATE_PASSWORD` - пароль сертификата
- `PROVISIONING_PROFILE` - Base64 provisioning profile

```bash
# Конвертируйте в Base64
base64 -i certificate.p12 | pbcopy
base64 -i profile.mobileprovision | pbcopy
```

### Шаг 3: Обновите workflow

Раскомментируйте секцию подписания в `.github/workflows/build-ios.yml`

## 📊 Мониторинг сборок

### Статус сборки

Добавьте badge в README:
```markdown
![Build Status](https://github.com/ВАШ_USERNAME/BluetoothMessengerIOS/workflows/Build%20iOS%20App/badge.svg)
```

### Email уведомления

GitHub автоматически отправляет email при:
- ✅ Успешной сборке
- ❌ Ошибке сборки

## 🎯 Что делает workflow?

1. **Checkout** - скачивает код
2. **Setup Xcode** - настраивает Xcode 16.0
3. **Build** - компилирует проект
4. **Archive** - создает архив
5. **Export** - экспортирует IPA (если настроено подписание)
6. **Upload** - загружает артефакты

## ⚙️ Настройка workflow

### Изменить версию Xcode

```yaml
- name: Setup Xcode
  uses: maxim-lobanov/setup-xcode@v1
  with:
    xcode-version: '15.4'  # Измените здесь
```

### Добавить тесты

```yaml
- name: Run Tests
  run: |
    xcodebuild test \
      -project BluetoothMessengerIOS.xcodeproj \
      -scheme BluetoothMessengerIOS \
      -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Сборка для разных конфигураций

```yaml
strategy:
  matrix:
    configuration: [Debug, Release]
```

## 🔍 Отладка

### Просмотр логов

1. Actions → выберите сборку
2. Кликните на job "Build and Archive"
3. Раскройте нужный step

### Частые ошибки

**"No signing certificate found"**
→ Настройте подписание или используйте `CODE_SIGNING_REQUIRED=NO`

**"Scheme not found"**
→ Проверьте название схемы в Xcode

**"Build failed"**
→ Проверьте что проект собирается локально

## 💰 Лимиты GitHub Actions

### Бесплатный план:
- 2000 минут/месяц
- Одна сборка ≈ 5-10 минут
- ≈ 200-400 сборок в месяц

### Платный план:
- $0.008 за минуту на macOS
- Неограниченное количество сборок

## 🚀 Продвинутые возможности

### Автоматический релиз

При создании тега:
```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions автоматически создаст Release с IPA файлом.

### Деплой в TestFlight

Добавьте в workflow:
```yaml
- name: Upload to TestFlight
  uses: apple-actions/upload-testflight-build@v1
  with:
    app-path: build/BluetoothMessengerIOS.ipa
    issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
    api-key-id: ${{ secrets.APPSTORE_API_KEY_ID }}
    api-private-key: ${{ secrets.APPSTORE_API_PRIVATE_KEY }}
```

### Уведомления в Telegram

```yaml
- name: Send Telegram Notification
  if: always()
  uses: appleboy/telegram-action@master
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: |
      Build ${{ job.status }}
      Commit: ${{ github.sha }}
```

## 📚 Полезные ссылки

- [GitHub Actions документация](https://docs.github.com/en/actions)
- [Xcode Cloud альтернатива](https://developer.apple.com/xcode-cloud/)
- [Fastlane для автоматизации](https://fastlane.tools)

## ❓ FAQ

**Q: Можно ли собрать без Apple ID?**
A: Да, но IPA не будет подписан и не установится на устройство.

**Q: Сколько стоит?**
A: Бесплатно до 2000 минут в месяц.

**Q: Работает ли для App Store?**
A: Да, но нужно настроить подписание и сертификаты.

**Q: Можно ли использовать для других проектов?**
A: Да, просто скопируйте `.github/workflows/build-ios.yml`
