@echo off
echo Building VibeCoding executable...

echo Installing dependencies...
call install_dependencies.bat

echo Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

echo Checking for VOSK model...
if not exist vosk-model-small-en-us-0.15 (
    echo VOSK model not found. Downloading it now...
    call download_model.bat
    if not exist vosk-model-small-en-us-0.15 (
        echo ERROR: Failed to download VOSK model. Build cannot continue.
        pause
        exit /b 1
    )
)

echo Creating placeholder icon if needed...
if not exist VibeCoding.ico (
    echo Creating placeholder icon...
    copy %SystemRoot%\System32\shell32.dll,1 VibeCoding.ico >nul 2>&1
    if not exist VibeCoding.ico (
        echo WARNING: Could not create placeholder icon. Using no icon.
        echo WARN_NO_ICON=1 > build.cfg
    )
)

echo Building executable with PyInstaller...
if exist build.cfg (
    findstr /b /c:"WARN_NO_ICON=1" build.cfg >nul && (
        pyinstaller --clean --name=VibeCoding --windowed --onefile app.py
    ) || (
        pyinstaller --clean VibeCoding.spec
    )
) else (
    pyinstaller --clean VibeCoding.spec
)

echo Checking build result...
if exist dist\VibeCoding.exe (
    echo Creating release zip...
    cd dist
    mkdir vosk-model-small-en-us-0.15
    xcopy /E /I /Y ..\vosk-model-small-en-us-0.15 vosk-model-small-en-us-0.15
    powershell Compress-Archive -Path VibeCoding.exe, vosk-model-small-en-us-0.15 -DestinationPath ..\VibeCoding.zip
    cd ..
    echo Build complete! 
    echo Executable is in the 'dist' folder.
    echo Zip file ready for GitHub release: VibeCoding.zip
) else (
    echo Build failed! Check the output for errors.
)

if exist build.cfg del build.cfg

pause 