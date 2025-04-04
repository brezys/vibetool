@echo off
echo Downloading Vosk speech recognition model...
echo This may take a few minutes depending on your internet connection.

mkdir temp_download
cd temp_download

echo Downloading from https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip
powershell -Command "& {Invoke-WebRequest -Uri 'https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip' -OutFile 'vosk-model.zip'}"

echo Extracting model...
powershell -Command "& {Expand-Archive -Path 'vosk-model.zip' -DestinationPath '..'}"

cd ..
rmdir /s /q temp_download

if exist vosk-model-small-en-us-0.15 (
    echo Model downloaded and extracted successfully!
) else (
    echo Error: Model extraction failed. Please download manually from:
    echo https://alphacephei.com/vosk/models
    echo Download 'vosk-model-small-en-us-0.15' and extract to this directory.
)

pause 