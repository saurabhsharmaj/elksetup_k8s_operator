@echo off
setlocal

echo ============================================
echo Elasticsearch CA Generator
echo ============================================

set ES_VERSION=9.1.0
set CONTAINER_NAME=es-certutil
set OUTPUT_DIR=%cd%\certs

:: Clean existing output directory
if exist "%OUTPUT_DIR%" (
    rmdir /s /q "%OUTPUT_DIR%"
)

mkdir "%OUTPUT_DIR%"

echo.
echo [1/6] Creating temporary container...
docker create --name %CONTAINER_NAME% docker.elastic.co/elasticsearch/elasticsearch:%ES_VERSION% >nul

if errorlevel 1 (
    echo Failed to create container.
    pause
    exit /b 1
)

echo.
echo [2/6] Starting container...
docker start %CONTAINER_NAME% >nul

if errorlevel 1 (
    echo Failed to start container.
    docker rm -f %CONTAINER_NAME% >nul
    pause
    exit /b 1
)

echo.
echo [3/6] Generating Certificate Authority...
docker exec %CONTAINER_NAME% bash -c "echo | bin/elasticsearch-certutil ca --pem --out /tmp/ca.zip"

if errorlevel 1 (
    echo Failed to generate CA.
    docker rm -f %CONTAINER_NAME% >nul
    pause
    exit /b 1
)

echo.
echo [4/6] Copying CA ZIP to host...
docker cp %CONTAINER_NAME%:/tmp/ca.zip "%OUTPUT_DIR%\ca.zip"

if errorlevel 1 (
    echo Failed to copy ca.zip.
    docker rm -f %CONTAINER_NAME% >nul
    pause
    exit /b 1
)

echo.
echo [5/6] Extracting and flattening folder structure...
powershell -NoProfile -ExecutionPolicy Bypass ^
"$ErrorActionPreference='Stop'; ^
Expand-Archive -LiteralPath '%OUTPUT_DIR%\ca.zip' -DestinationPath '%OUTPUT_DIR%' -Force; ^
Move-Item -Path '%OUTPUT_DIR%\ca\*' -Destination '%OUTPUT_DIR%' -Force; ^
Remove-Item -Path '%OUTPUT_DIR%\ca' -Recurse -Force; ^
Remove-Item -Path '%OUTPUT_DIR%\ca.zip' -Force"

if errorlevel 1 (
    echo Failed to extract CA.
    docker rm -f %CONTAINER_NAME% >nul
    pause
    exit /b 1
)

echo.
echo [6/6] Cleaning up...
docker rm -f %CONTAINER_NAME% >nul

echo.
echo ============================================
echo SUCCESS!
echo ============================================
echo.
echo Generated certificates:
echo.
echo   %OUTPUT_DIR%\ca.crt
echo   %OUTPUT_DIR%\ca.key
echo.

dir "%OUTPUT_DIR%"

pause