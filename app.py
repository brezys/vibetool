import os
import sys
import json
import queue
import threading
import pyaudio
import tkinter as tk
import pyautogui
from tkinter import ttk, messagebox
from vosk import Model, KaldiRecognizer

class VibeCodingApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Vibe Coding - Speech to Text")
        self.root.geometry("400x200")
        self.root.resizable(False, False)
        
        # Set up UI elements
        self.setup_ui()
        
        # Speech recognition variables
        self.is_listening = False
        self.q = queue.Queue()
        self.model = None
        self.recognizer = None
        self.audio = None
        self.listen_thread = None
        
        # Status variables
        self.status = "Stopped"
        self.update_status_display()
        
        # Initialize Vosk model
        self.initialize_vosk()
    
    def setup_ui(self):
        # Create a frame with padding
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Application title
        title_label = ttk.Label(main_frame, text="Vibe Coding", font=("Arial", 16, "bold"))
        title_label.pack(pady=10)
        
        # Status display
        self.status_label = ttk.Label(main_frame, text="Status: Stopped", font=("Arial", 10))
        self.status_label.pack(pady=5)
        
        # Create button frame
        button_frame = ttk.Frame(main_frame)
        button_frame.pack(pady=10)
        
        # Start button
        self.start_button = ttk.Button(button_frame, text="Start Listening", command=self.start_listening)
        self.start_button.pack(side=tk.LEFT, padx=10)
        
        # Stop button
        self.stop_button = ttk.Button(button_frame, text="Stop Listening", command=self.stop_listening, state=tk.DISABLED)
        self.stop_button.pack(side=tk.LEFT, padx=10)
        
        # Help text
        help_text = "Position your cursor where you want to type, then start listening."
        help_label = ttk.Label(main_frame, text=help_text, font=("Arial", 9), foreground="gray")
        help_label.pack(pady=10)
    
    def initialize_vosk(self):
        # Path to Vosk model - will download if not present
        model_path = "vosk-model-small-en-us-0.15"
        
        # Check if model exists, if not, inform user to download
        if not os.path.exists(model_path):
            messagebox.showinfo(
                "Model Required", 
                "Vosk model not found. Please download the model from https://alphacephei.com/vosk/models\n"
                "Download 'vosk-model-small-en-us-0.15' and extract to the application directory."
            )
            self.status = "Model missing"
            self.update_status_display()
            return
        
        try:
            self.model = Model(model_path)
            self.status = "Ready"
            self.update_status_display()
        except Exception as e:
            messagebox.showerror("Error", f"Failed to initialize Vosk model: {str(e)}")
            self.status = "Error"
            self.update_status_display()
    
    def update_status_display(self):
        self.status_label.config(text=f"Status: {self.status}")
    
    def start_listening(self):
        if not self.model:
            messagebox.showerror("Error", "Speech recognition model not initialized")
            return
        
        if self.is_listening:
            return
        
        self.is_listening = True
        self.status = "Listening"
        self.update_status_display()
        
        # Update button states
        self.start_button.config(state=tk.DISABLED)
        self.stop_button.config(state=tk.NORMAL)
        
        # Initialize audio
        self.audio = pyaudio.PyAudio()
        
        # Start recognition in a separate thread
        self.listen_thread = threading.Thread(target=self.recognition_thread)
        self.listen_thread.daemon = True
        self.listen_thread.start()
    
    def stop_listening(self):
        if not self.is_listening:
            return
        
        self.is_listening = False
        self.status = "Stopped"
        self.update_status_display()
        
        # Update button states
        self.start_button.config(state=tk.NORMAL)
        self.stop_button.config(state=tk.DISABLED)
        
        # Clean up audio resources
        if self.audio:
            self.audio.terminate()
            self.audio = None
    
    def recognition_thread(self):
        # Create recognizer with 16kHz sample rate
        self.recognizer = KaldiRecognizer(self.model, 16000)
        
        # Open microphone stream
        stream = self.audio.open(
            format=pyaudio.paInt16,
            channels=1,
            rate=16000,
            input=True,
            frames_per_buffer=4000,
            stream_callback=self.audio_callback
        )
        
        stream.start_stream()
        
        # Process recognition results
        while self.is_listening:
            try:
                data = self.q.get(block=False)
                if self.recognizer.AcceptWaveform(data):
                    result = json.loads(self.recognizer.Result())
                    text = result.get("text", "").strip()
                    if text:
                        # Type the recognized text at cursor position
                        pyautogui.typewrite(text + " ")
            except queue.Empty:
                pass
        
        # Clean up
        stream.stop_stream()
        stream.close()
    
    def audio_callback(self, in_data, frame_count, time_info, status):
        if self.is_listening:
            self.q.put(in_data)
        return None, pyaudio.paContinue

def main():
    root = tk.Tk()
    app = VibeCodingApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()