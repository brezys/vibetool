@echo off
echo Cleaning up previous build files...

echo Removing build directory...
if exist build rmdir /s /q build

echo Removing dist directory...
if exist dist rmdir /s /q dist

echo Removing PyInstaller spec cache...
if exist __pycache__ rmdir /s /q __pycache__

echo Removing VibeCoding.zip...
if exist VibeCoding.zip del VibeCoding.zip

echo Removing temporary files...
del /q *.log 2>nul
del /q *.pyc 2>nul

echo Preserving VibeCoding.spec file

echo Cleanup complete! Ready for fresh build.
pause 