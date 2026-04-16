# 📱 Установка iOS приложения БЕЗ Mac

Если у вас нет Mac, есть несколько способов собрать и установить iOS приложение.

## 🌐 Способ 1: Облачный Mac (САМЫЙ ПРОСТОЙ)

### MacStadium / MacinCloud
Аренда виртуального Mac в облаке.

**Цена:** от $1/час или $30/месяц

**Шаги:**
1. Зарегистрируйтесь на https://www.macincloud.com или https://www.macstadium.com
2. Арендуйте Mac на час
3. Подключитесь через Remote Desktop
4. Установите Xcode
5. Соберите проект и создайте IPA
6. Скачайте IPA файл
7. Установите через AltStore (см. ниже)

**Плюсы:**
- ✅ Полноценный Mac
- ✅ Можно собрать IPA
- ✅ Платите только за использование

**Минусы:**
- ❌ Нужно платить
- ❌ Медленное интернет-соединение

---

## 🔧 Способ 2: GitHub Actions (БЕСПЛАТНО!)

Используем бесплатные CI/CD серверы GitHub для сборки.

### Шаги:

1. **Создайте репозиторий на GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/ВАШ_USERNAME/BluetoothMessengerIOS.git
   git push -u origin main
   ```

2. **Создайте workflow файл**
   
   Создайте `.github/workflows/build.yml`:
   ```yaml
   name: Build iOS App
   
   on:
     push:
       branches: [ main ]
     workflow_dispatch:
   
   jobs:
     build:
       runs-on: macos-latest
       
       steps:
       - name: Checkout
         uses: actions/checkout@v3
       
       - name: Setup Xcode
         uses: maxim-lobanov/setup-xcode@v1
         with:
           xcode-version: latest-stable
       
       - name: Build Archive
         run: |
           xcodebuild -project BluetoothMessengerIOS.xcodeproj \
                      -scheme BluetoothMessengerIOS \
                      -configuration Release \
                      -archivePath $PWD/build/BluetoothMessengerIOS.xcarchive \
                      archive
       
       - name: Export IPA
         run: |
           xcodebuild -exportArchive \
                      -archivePath $PWD/build/BluetoothMessengerIOS.xcarchive \
                      -exportPath $PWD/build \
                      -exportOptionsPlist ExportOptions.plist
       
       - name: Upload IPA
         uses: actions/upload-artifact@v3
         with:
           name: BluetoothMessengerIOS
           path: build/*.ipa
   ```

3. **Создайте ExportOptions.plist**
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>method</key>
       <string>development</string>
       <key>compileBitcode</key>
       <false/>
   </dict>
   </plist>
   ```

4. **Запустите workflow**
   - Перейдите на GitHub → Actions
   - Выберите workflow
   - Run workflow
   - Дождитесь завершения (5-10 минут)
   - Скачайте IPA из Artifacts

**Плюсы:**
- ✅ Полностью бесплатно
- ✅ Автоматическая сборка
- ✅ 2000 минут/месяц бесплатно

**Минусы:**
- ❌ Нужно разобраться с Git
- ❌ Сложнее настроить подписание

---

## 📦 Способ 3: Готовый IPA (если кто-то соберет)

Если у друга есть Mac, попросите собрать IPA и установите через:

### A. AltStore (Windows/Linux)

1. **Установите AltServer**
   - Windows: https://altstore.io
   - Linux: https://github.com/NyaMisty/AltServer-Linux

2. **Установите AltStore на iPhone**
   - Подключите iPhone к компьютеру
   - Запустите AltServer
   - Install AltStore → выберите iPhone
   - Введите Apple ID

3. **Установите IPA**
   - Откройте AltStore на iPhone
   - My Apps → +
   - Выберите IPA файл
   - Готово!

**Важно:** Приложение работает 7 дней, потом нужно обновить через AltStore

### B. Sideloadly (Windows/Mac/Linux)

1. **Скачайте Sideloadly**
   - https://sideloadly.io

2. **Установите IPA**
   - Запустите Sideloadly
   - Подключите iPhone
   - Перетащите IPA файл
   - Введите Apple ID
   - Нажмите Start

### C. 3uTools (Windows)

1. **Скачайте 3uTools**
   - http://www.3u.com

2. **Установите IPA**
   - Подключите iPhone
   - Apps → Import & Install
   - Выберите IPA файл

---

## 🌍 Способ 4: Онлайн сервисы сборки

### Codemagic (бесплатный план)

1. Зарегистрируйтесь на https://codemagic.io
2. Подключите GitHub репозиторий
3. Настройте workflow
4. Запустите сборку
5. Скачайте IPA

**Бесплатно:** 500 минут сборки/месяц

### Bitrise (бесплатный план)

1. Зарегистрируйтесь на https://www.bitrise.io
2. Добавьте проект
3. Настройте workflow
4. Соберите IPA

**Бесплатно:** 200 минут сборки/месяц

---

## 🎯 Рекомендации

### Если нужно один раз попробовать:
→ **GitHub Actions** (бесплатно) или **MacinCloud** ($1 на час)

### Если нужно регулярно обновлять:
→ **GitHub Actions** + **AltStore**

### Если есть друг с Mac:
→ Попросите собрать IPA → установите через **AltStore**

### Если готовы платить:
→ **MacinCloud** ($30/месяц) - полноценный Mac в облаке

---

## ⚠️ Важные ограничения

### Без платного Apple Developer аккаунта:
- ❌ Приложение работает только 7 дней
- ❌ Максимум 3 приложения одновременно
- ❌ Нужно переустанавливать каждую неделю

### С платным аккаунтом ($99/год):
- ✅ Приложения работают 1 год
- ✅ Можно использовать TestFlight
- ✅ Неограниченное количество приложений

---

## 🔄 Альтернатива: Веб-версия

Если все это слишком сложно, можно создать веб-версию приложения:

### Progressive Web App (PWA)
- Работает в Safari на iPhone
- Можно добавить на домашний экран
- Не требует установки
- Но нет доступа к Bluetooth напрямую

Хотите, чтобы я создал PWA версию?

---

## 📞 Помощь

### Если ничего не получается:

1. **Попросите друга с Mac** - самый простой вариант
2. **Используйте GitHub Actions** - бесплатно, но нужно разобраться
3. **Арендуйте Mac на час** - $1-2, быстро и просто
4. **Купите Mac Mini** - от $599, если планируете разработку

### Telegram группы помощи:
- iOS Developers RU
- Swift Developers
- Hackintosh (если хотите установить macOS на PC)

---

## 🖥️ Бонус: Hackintosh

Если у вас мощный PC, можно установить macOS:

**Требования:**
- Intel процессор (AMD сложнее)
- 16GB+ RAM
- SSD
- Совместимая видеокарта

**Ресурсы:**
- https://dortania.github.io/OpenCore-Install-Guide/
- r/hackintosh на Reddit

**Внимание:** Это нарушает лицензию Apple, но технически возможно.
