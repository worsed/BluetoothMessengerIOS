#!/bin/bash

# Скрипт автоматической настройки GitHub и запуска сборки

echo "🚀 Настройка GitHub для BluetoothMessengerIOS"
echo ""

# Проверка git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен. Установите git: https://git-scm.com"
    exit 1
fi

# Проверка gh CLI (опционально)
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI не установлен (опционально)"
    echo "   Установите для автоматизации: https://cli.github.com"
    echo ""
fi

# Запрос данных пользователя
echo "📝 Введите ваши данные:"
read -p "Ваше имя: " USER_NAME
read -p "Ваш email: " USER_EMAIL
read -p "Ваш GitHub username: " GITHUB_USERNAME
read -p "Название репозитория [BluetoothMessengerIOS]: " REPO_NAME
REPO_NAME=${REPO_NAME:-BluetoothMessengerIOS}

echo ""
echo "✅ Настройка Git..."

# Настройка git
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

# Инициализация репозитория
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git репозиторий инициализирован"
fi

# Добавление файлов
git add .
git commit -m "Initial commit: Bluetooth Messenger iOS app" 2>/dev/null || echo "⚠️  Нет изменений для коммита"

# Проверка наличия gh CLI
if command -v gh &> /dev/null; then
    echo ""
    echo "🔐 Авторизация в GitHub..."
    gh auth status &> /dev/null || gh auth login
    
    echo ""
    echo "📦 Создание репозитория на GitHub..."
    gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
    
    echo ""
    echo "🚀 Запуск GitHub Actions..."
    gh workflow run build-ios.yml
    
    echo ""
    echo "✅ Готово! Сборка запущена."
    echo ""
    echo "📊 Проверить статус:"
    echo "   gh run list"
    echo ""
    echo "📥 Скачать результат после завершения:"
    echo "   gh run download"
    
else
    # Ручная настройка
    echo ""
    echo "📦 Создайте репозиторий вручную:"
    echo "   1. Перейдите на https://github.com/new"
    echo "   2. Название: $REPO_NAME"
    echo "   3. Public"
    echo "   4. НЕ добавляйте README"
    echo "   5. Create repository"
    echo ""
    read -p "Нажмите Enter после создания репозитория..."
    
    # Добавление remote
    REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
    
    echo ""
    echo "📤 Загрузка кода на GitHub..."
    git branch -M main
    git push -u origin main
    
    echo ""
    echo "✅ Код загружен!"
    echo ""
    echo "🚀 Запустите сборку:"
    echo "   1. Перейдите на https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo "   2. Actions → Build iOS App"
    echo "   3. Run workflow → Run workflow"
    echo "   4. Дождитесь завершения (5-10 минут)"
    echo "   5. Скачайте Artifacts"
fi

echo ""
echo "📱 После сборки установите через AltStore:"
echo "   https://altstore.io"
echo ""
echo "📚 Документация:"
echo "   - NO_MAC_GUIDE.md - установка без Mac"
echo "   - GITHUB_ACTIONS_SETUP.md - настройка GitHub Actions"
echo ""
