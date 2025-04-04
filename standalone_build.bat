@echo off
echo ===== VibeCoding Complete Build Process =====

echo Step 1: Checking for VOSK model...
if not exist vosk-model-small-en-us-0.15 (
    echo VOSK model not found. Downloading it now...
    call download_model.bat
    if not exist vosk-model-small-en-us-0.15 (
        echo ERROR: Failed to download VOSK model. Build cannot continue.
        pause
        exit /b 1
    )
)

echo Step 2: Cleaning previous build artifacts...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist __pycache__ rmdir /s /q __pycache__
if exist VibeCoding.zip del VibeCoding.zip
del /q *.log 2>nul
del /q *.pyc 2>nul

echo Step 3: Creating placeholder icon if needed...
if not exist VibeCoding.ico (
    echo Creating placeholder icon...
    echo Using a default application icon
    powershell -Command "& {Add-Type -AssemblyName System.Drawing; $icon = [System.Drawing.SystemIcons]::Application; $bitmap = $icon.ToBitmap(); $bitmap.Save('VibeCoding.ico')}"
    if not exist VibeCoding.ico (
        echo WARNING: Could not create icon. The executable will use the default PyInstaller icon.
    )
)

echo Step 4: Checking for dependencies...
call install_dependencies.bat

echo Step 5: Building executable...
pyinstaller --clean --noconfirm --name=VibeCoding ^
    --windowed ^
    --add-data="vosk-model-small-en-us-0.15;vosk-model-small-en-us-0.15" ^
    --hidden-import=vosk ^
    --icon=VibeCoding.ico ^
    app.py

echo Step 6: Creating distribution package...
if exist dist\VibeCoding.exe (
    echo Build successful! Creating zip file...
    cd dist
    
    echo Copying VOSK model to distribution...
    if not exist vosk-model-small-en-us-0.15 (
        mkdir vosk-model-small-en-us-0.15
        xcopy /E /I /Y ..\vosk-model-small-en-us-0.15 vosk-model-small-en-us-0.15
    )
    
    echo Creating README...
    echo VibeCoding - Speech-to-Text Application > README.txt
    echo. >> README.txt
    echo Simply run VibeCoding.exe to start the application. >> README.txt
    echo The VOSK model folder must be in the same directory as the executable. >> README.txt
    echo. >> README.txt
    echo For more information, visit: https://github.com/brezys/vibetool >> README.txt
    
    echo Creating zip archive...
    powershell Compress-Archive -Path VibeCoding.exe, vosk-model-small-en-us-0.15, README.txt -DestinationPath ..\VibeCoding.zip
    cd ..
    
    echo ===== BUILD COMPLETE =====
    echo Executable is in the 'dist' folder.
    echo Zip file ready for release: VibeCoding.zip
) else (
    echo Build failed! Check the output for errors.
)

pause 