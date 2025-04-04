@echo off
echo Installing dependencies for VibeCoding...

echo Installing pip tools...
pip install -U pip setuptools wheel

echo Installing pipwin (for PyAudio)...
pip install pipwin

echo Installing PyAudio through pipwin...
pipwin install pyaudio

echo Installing other dependencies...
pip install vosk==0.3.45
pip install pyautogui==0.9.54
pip install pyinstaller==6.12.0

echo Dependency installation complete!
echo.
echo If PyAudio installation failed, try these alternatives:
echo 1. Use Python 3.9 or 3.10 instead of 3.12
echo 2. Download a PyAudio wheel from https://www.lfd.uci.edu/~gohlke/pythonlibs/#pyaudio
echo    and install with: pip install [wheel_filename]
echo.
pause 