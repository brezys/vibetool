@echo off
echo Building VibeCoding executable...

echo Installing dependencies...
pip install -r requirements.txt

echo Cleaning previous builds...
rmdir /s /q build
rmdir /s /q dist

echo Building executable with PyInstaller...
pyinstaller VibeCoding.spec

echo Creating release zip...
cd dist
powershell Compress-Archive -Path VibeCoding.exe -DestinationPath ..\VibeCoding.zip
cd ..

echo Build complete! 
echo Executable is in the 'dist' folder.
echo Zip file ready for GitHub release: VibeCoding.zip
pause 