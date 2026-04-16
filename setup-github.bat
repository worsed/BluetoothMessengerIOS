@echo off
REM Скрипт автоматической настройки GitHub для Windows

echo ========================================
echo   Настройка GitHub для BluetoothMessengerIOS
echo ========================================
echo.

REM Проверка git
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git не установлен!
    echo Скачайте с https://git-scm.com
    pause
    exit /b 1
)

echo [OK] Git установлен
echo.

REM Запрос данных
set /p USER_NAME="Ваше имя: "
set /p USER_EMAIL="Ваш email: "
set /p GITHUB_USERNAME="Ваш GitHub username: "
set /p REPO_NAME="Название репозитория [BluetoothMessengerIOS]: "
if "%REPO_NAME%"=="" set REPO_NAME=BluetoothMessengerIOS

echo.
echo [INFO] Настройка Git...

REM Настройка git
git config user.name "%USER_NAME%"
git config user.email "%USER_EMAIL%"

REM Инициализация
if not exist ".git" (
    git init
    echo [OK] Git репозиторий инициализирован
)

REM Добавление файлов
git add .
git commit -m "Initial commit: Bluetooth Messenger iOS app"

echo.
echo ========================================
echo   Создайте репозиторий на GitHub
echo ========================================
echo.
echo 1. Перейдите на https://github.com/new
echo 2. Название: %REPO_NAME%
echo 3. Public
echo 4. НЕ добавляйте README
echo 5. Create repository
echo.
pause

REM Добавление remote
set REPO_URL=https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
git remote add origin %REPO_URL% 2>nul
git remote set-url origin %REPO_URL%

echo.
echo [INFO] Загрузка кода на GitHub...
git branch -M main
git push -u origin main

echo.
echo ========================================
echo   Готово!
echo ========================================
echo.
echo Запустите сборку:
echo 1. https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
echo 2. Actions - Build iOS App
echo 3. Run workflow - Run workflow
echo 4. Дождитесь завершения (5-10 минут)
echo 5. Скачайте Artifacts
echo.
echo После сборки установите через AltStore:
echo https://altstore.io
echo.
pause
