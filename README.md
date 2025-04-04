<<<<<<< HEAD
# Vibe Coding - Speech-to-Text Desktop Application

This application enables "vibe coding" by transcribing speech to text in real-time and typing it at your cursor position.

## Installation

1. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Download Vosk Model**:
   - Visit https://alphacephei.com/vosk/models
   - Download the `vosk-model-small-en-us-0.15` model
   - Extract the model folder to the same directory as the application

## Usage

1. **Start the Application**:
   ```bash
   python vibe_coding_app.py
   ```

2. **Using the Application**:
   - Position your cursor where you want the text to appear (e.g., in your code editor)
   - Click "Start Listening" to begin speech recognition
   - Speak clearly into your microphone
   - The application will transcribe your speech and type it at the cursor position
   - Click "Stop Listening" when you're done

## Tips for Best Results

- Use a good quality microphone in a quiet environment
- Speak clearly and at a moderate pace
- For coding-specific terms, pronounce them distinctly
- The application works in any text field where you can position your cursor
- If accuracy is poor, try repositioning your microphone or moving to a quieter location

## Troubleshooting

- If the application cannot find the Vosk model, ensure you've downloaded and extracted it correctly
- If PyAudio installation fails, you may need additional system dependencies:
  - On Windows: `pip install pipwin` followed by `pipwin install pyaudio`
  - On macOS: `brew install portaudio` followed by `pip install pyaudio`
  - On Linux: `sudo apt-get install python3-pyaudio` or equivalent for your distribution

## License

This application uses:
- Vosk: Apache 2.0 License
- PyAutoGUI: BSD 3-Clause License
- PyAudio: MIT License
=======
# Vibe Coding - Speech to Text Application

A simple speech recognition application that converts your voice to text at the cursor position. Great for hands-free typing!

## Features

- Real-time speech to text conversion using the VOSK speech recognition model
- Place text at your cursor position
- Toggle speech recognition on/off with the ESC key (can be disabled)
- Lightweight and easy to use

## Download & Installation

### Quick Start (Windows)

1. Go to the [Releases](https://github.com/YOUR_USERNAME/vibe-coding/releases) page
2. Download the latest `VibeCoding.zip` file
3. Extract the zip file
4. Double-click on `VibeCoding.exe` to run the application

That's it! No installation needed.

### From Source

1. Clone the repository
   ```
   git clone https://github.com/YOUR_USERNAME/vibe-coding.git
   cd vibe-coding
   ```

2. Install dependencies
   ```
   pip install -r requirements.txt
   ```

3. Download the VOSK model
   - Download `vosk-model-small-en-us-0.15` from [VOSK Models](https://alphacephei.com/vosk/models)
   - Extract it to the root of the project folder

4. Run the application
   ```
   python app.py
   ```

## Usage

1. Position your cursor where you want to type text
2. Click "Start Listening" or press the ESC key
3. Speak clearly into your microphone
4. Click "Stop Listening" or press ESC again to stop
5. The recognized text will appear at your cursor position

## Building from Source

To build the executable yourself:

1. Create your own `VibeCoding.ico` file or use an existing one in the project folder
2. Run the build script:
   ```
   build.bat
   ```
3. Find the executable in the `dist` folder and a zip file ready for distribution in the project root

## Requirements

- Python 3.7 or higher
- PyAudio
- VOSK
- PyAutoGUI
- PyInstaller (for building)

## License

MIT

## Acknowledgements

- [VOSK Speech Recognition Toolkit](https://github.com/alphacep/vosk-api) 
>>>>>>> 5fdc6c0 (Initial commit with executable build)
