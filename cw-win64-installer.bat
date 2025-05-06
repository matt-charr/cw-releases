@echo off
setlocal enabledelayedexpansion

set "REPO=matt-charr/cw-releases"
set "TARGET_PATTERN=cw-*-linux.zip"
set "DEST_DIR=cw-win64"

echo === Step 1 : Donwload latest release ===
gh release download --repo %REPO% --pattern %TARGET_PATTERN%

if errorlevel 1 (
    echo Download failure
    exit /b 1
)

echo === Step 2 : Extraction              ===
if exist "%DEST_DIR%" rmdir /s /q "%DEST_DIR%"
powershell -NoProfile -Command "Expand-Archive -Path '%TARGET_PATTERN%' -DestinationPath '%DEST_DIR%' -Force"
if errorlevel 1 (
    echo Extraction failure.
    exit /b 1
)

echo === Step 3 : Cleanup                 ===
del "%TARGET_PATTERN%"

echo === Finished                         ===
echo File extracted in : "%DEST_DIR%"
pause