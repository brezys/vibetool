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
