# 🔧 Настройка Git и загрузка на GitHub

## Проблема с SSL сертификатом (Windows)

Если видите ошибку `SEC_E_UNTRUSTED_ROOT`, вот решения:

### Решение 1: Отключить проверку SSL (быстро)

Откройте PowerShell или CMD и выполните:

```bash
git config --global http.sslVerify false
```

Затем попробуйте снова:
```bash
git push -u origin main
```

### Решение 2: Использовать GitHub Desktop (РЕКОМЕНДУЕТСЯ)

1. **Скачайте GitHub Desktop**
   - https://desktop.github.com
   - Установите и войдите в аккаунт

2. **Добавьте репозиторий**
   - File → Add Local Repository
   - Выберите папку `BluetoothMessengerIOS`

3. **Опубликуйте**
   - Publish repository
   - Название: `BluetoothMessengerIOS`
   - Нажмите "Publish repository"

4. **Готово!**
   - Репозиторий автоматически загрузится на GitHub
   - GitHub Actions запустится автоматически

### Решение 3: Использовать SSH вместо HTTPS

```bash
# Создайте SSH ключ
ssh-keygen -t ed25519 -C "your_email@example.com"

# Скопируйте публичный ключ
cat ~/.ssh/id_ed25519.pub

# Добавьте на GitHub:
# Settings → SSH and GPG keys → New SSH key

# Измените remote на SSH
git remote set-url origin git@github.com:worsed/BluetoothMessengerIOS.git

# Теперь push
git push -u origin main
```

### Решение 4: Обновить Git

Возможно у вас старая версия Git:

```bash
# Скачайте последнюю версию
# https://git-scm.com/download/win

# Или через winget
winget install Git.Git
```

## Настройка автора

Перед первым коммитом настройте имя и email:

```bash
git config --global user.name "Ваше Имя"
git config --global user.email "your_email@example.com"
```

## Полная инструкция загрузки

### Шаг 1: Инициализация (если еще не сделали)

```bash
cd BluetoothMessengerIOS
git init
```

### Шаг 2: Настройка автора

```bash
git config user.name "Ваше Имя"
git config user.email "your_email@example.com"
```

### Шаг 3: Добавление файлов

```bash
git add .
git commit -m "Initial commit: Bluetooth Messenger iOS"
```

### Шаг 4: Создание репозитория на GitHub

1. Перейдите на https://github.com/new
2. Repository name: `BluetoothMessengerIOS`
3. Public или Private (на ваш выбор)
4. НЕ добавляйте README, .gitignore, license
5. Create repository

### Шаг 5: Подключение и загрузка

```bash
git remote add origin https://github.com/worsed/BluetoothMessengerIOS.git
git branch -M main
git push -u origin main
```

Если ошибка SSL - используйте GitHub Desktop (Решение 2)

## После загрузки

### Проверка GitHub Actions

1. Перейдите на GitHub.com в ваш репозиторий
2. Вкладка "Actions"
3. Должна запуститься сборка "Build iOS App"
4. Дождитесь завершения (5-10 минут)

### Скачивание IPA

1. Actions → выберите завершенную сборку
2. Artifacts → скачайте файлы
3. Установите через AltStore (см. NO_MAC_GUIDE.md)

## Альтернатива: Загрузка через веб-интерфейс

Если git совсем не работает:

1. Создайте репозиторий на GitHub.com
2. Нажмите "uploading an existing file"
3. Перетащите все файлы из папки
4. Commit changes
5. GitHub Actions запустится автоматически

## Проверка настроек

```bash
# Проверить текущие настройки
git config --list

# Проверить remote
git remote -v

# Проверить статус
git status
```

## Частые ошибки

### "Author identity unknown"
```bash
git config user.name "Ваше Имя"
git config user.email "email@example.com"
```

### "Permission denied"
→ Используйте SSH или GitHub Desktop

### "Repository not found"
→ Проверьте что репозиторий создан на GitHub

### "SSL certificate problem"
→ Используйте GitHub Desktop или отключите SSL проверку

## Обновление кода

После изменений:

```bash
git add .
git commit -m "Описание изменений"
git push
```

GitHub Actions автоматически пересоберет приложение!
