# 🖥️ Загрузка проекта через GitHub Desktop (самый простой способ)

Если git в командной строке не работает, используйте GitHub Desktop - это графический интерфейс.

## Шаг 1: Установка GitHub Desktop

1. Скачайте с https://desktop.github.com
2. Установите программу
3. Запустите и войдите в GitHub аккаунт

## Шаг 2: Добавление проекта

1. **File → Add Local Repository**
2. Выберите папку `BluetoothMessengerIOS`
3. Если появится "This directory does not appear to be a Git repository":
   - Нажмите "Create a repository"
   - Name: `BluetoothMessengerIOS`
   - Нажмите "Create Repository"

## Шаг 3: Первый коммит

1. В левой панели увидите список файлов
2. Убедитесь что все файлы отмечены галочками
3. Внизу слева в поле "Summary" напишите: `Initial commit`
4. Нажмите синюю кнопку "Commit to main"

## Шаг 4: Публикация на GitHub

1. Вверху нажмите "Publish repository"
2. Name: `BluetoothMessengerIOS`
3. Description: `Bluetooth Messenger for iOS`
4. Выберите Public или Private
5. Снимите галочку "Keep this code private" если хотите публичный репозиторий
6. Нажмите "Publish repository"

## Шаг 5: Проверка сборки

1. Откройте браузер
2. Перейдите на https://github.com/ваш_username/BluetoothMessengerIOS
3. Вкладка "Actions"
4. Должна запуститься сборка "Build iOS App"
5. Дождитесь зеленой галочки (5-10 минут)

## Шаг 6: Скачивание IPA

1. Кликните на завершенную сборку
2. Прокрутите вниз до "Artifacts"
3. Скачайте:
   - `BluetoothMessengerIOS-Archive`
   - `BluetoothMessengerIOS-App`

## Шаг 7: Установка на iPhone

Используйте AltStore (см. NO_MAC_GUIDE.md):

1. Установите AltStore на компьютер и iPhone
2. Откройте AltStore на iPhone
3. My Apps → +
4. Выберите скачанный .ipa файл
5. Готово!

## Обновление проекта

Когда вы изменили код:

1. Откройте GitHub Desktop
2. Увидите список изменений слева
3. Напишите описание изменений
4. Нажмите "Commit to main"
5. Нажмите "Push origin" вверху
6. GitHub Actions автоматически пересоберет приложение!

## Преимущества GitHub Desktop

- ✅ Не нужно знать команды git
- ✅ Визуальный интерфейс
- ✅ Автоматически решает проблемы с SSL
- ✅ Показывает изменения в файлах
- ✅ Легко откатить изменения

## Скриншоты процесса

### 1. Добавление репозитория
```
File → Add Local Repository → Choose... → BluetoothMessengerIOS
```

### 2. Первый коммит
```
Summary: Initial commit
Description: (опционально)
[Commit to main]
```

### 3. Публикация
```
[Publish repository]
Name: BluetoothMessengerIOS
[Publish repository]
```

## Альтернатива: Создать репозиторий сначала на GitHub

1. **На GitHub.com:**
   - New repository
   - Name: `BluetoothMessengerIOS`
   - Create repository

2. **В GitHub Desktop:**
   - File → Clone Repository
   - Выберите созданный репозиторий
   - Clone

3. **Скопируйте файлы:**
   - Скопируйте все файлы проекта в склонированную папку

4. **Коммит и Push:**
   - GitHub Desktop покажет изменения
   - Commit to main
   - Push origin

## Готово!

Теперь ваш проект на GitHub и автоматически собирается при каждом изменении!

Следующий шаг: установка на iPhone через AltStore (см. NO_MAC_GUIDE.md)
