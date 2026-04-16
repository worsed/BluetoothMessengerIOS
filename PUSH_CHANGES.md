# 🚀 Как загрузить изменения на GitHub

Я исправил ошибки в проекте. Теперь нужно загрузить изменения на GitHub.

## Способ 1: GitHub Desktop (ПРОЩЕ ВСЕГО)

1. **Откройте GitHub Desktop**

2. **Увидите список изменений:**
   - `.github/workflows/build-ios.yml` - исправлена версия Xcode
   - `Info.plist` - изменена минимальная версия iOS на 17.0
   - `README.md` - обновлены требования
   - `ExportOptions.plist` - добавлен новый файл

3. **Сделайте коммит:**
   - В поле "Summary" напишите: `Fix build errors`
   - Нажмите синюю кнопку "Commit to main"

4. **Загрузите на GitHub:**
   - Нажмите "Push origin" вверху

5. **Проверьте сборку:**
   - Откройте https://github.com/worsed/BluetoothMessengerIOS
   - Вкладка "Actions"
   - Новая сборка должна запуститься автоматически

## Способ 2: Командная строка

Откройте PowerShell в папке проекта:

```bash
cd BluetoothMessengerIOS

# Добавить все изменения
git add .

# Сделать коммит
git commit -m "Fix build errors: update Xcode version and iOS target"

# Загрузить на GitHub
git push
```

## Что было исправлено?

### 1. Версия Xcode
**Было:** `xcode-version: '16.0'` (не существует)  
**Стало:** `xcode-version: 'latest-stable'` (последняя доступная)

### 2. Минимальная версия iOS
**Было:** iOS 18.0 (еще не вышла)  
**Стало:** iOS 17.0 (текущая стабильная)

### 3. Runner
**Было:** `macos-14`  
**Стало:** `macos-latest` (автоматически последняя версия)

## После загрузки

1. GitHub Actions автоматически запустит новую сборку
2. Сборка займет 5-10 минут
3. Если все ОК - увидите зеленую галочку ✅
4. Скачайте IPA из Artifacts

## Если снова ошибка

Напишите текст ошибки, и я помогу исправить!

## Доступные версии Xcode на GitHub Actions

Сейчас доступны:
- ✅ Xcode 16.2 (последняя)
- ✅ Xcode 16.1
- ✅ Xcode 15.4
- ✅ Xcode 15.3
- ✅ Xcode 15.2
- ✅ Xcode 15.1
- ✅ Xcode 15.0.1

Мы используем `latest-stable` - это автоматически выберет Xcode 16.2.
