# WhisperX Transcription GUI

A GUI for transcribing audio and video files using [WhisperX](https://github.com/m-bain/whisperX), with CUDA acceleration for NVIDIA RTX 4070.

Updated to support the latest version of whisperx as of 4/1/2025.

Transcripts are saved as both `.srt` and `.txt` files in a `transcripts/` folder next to the script.

## Requirements

- Windows 11 (AMD64)
- NVIDIA RTX 4070 (or compatible GPU)
- Git Bash
- Python 3.12.0
- CUDA 12.8.0
- cuDNN 9.x (I tested with 9.20 and 9.15)

## Setup

### 1. Install CUDA Toolkit 12.8.1

Download and run the installer:

```
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/network_installers/cuda_12.8.1_windows_network.exe
```

After installing, set the `CUDA_PATH` environment variable if it wasn't set automatically:
- Value: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8`

### 2. Install cuDNN 9.20

Download and run the installer:

```
wget https://developer.download.nvidia.com/compute/cudnn/9.20.0/local_installers/cudnn_9.20.0_windows_x86_64.exe
```

Add the cuDNN `bin` folder to your system `PATH`:
- `C:\Program Files\NVIDIA\CUDNN\v9.20\bin\12.9`

### 3. Install Python 3.12.0

Download from [python.org](https://www.python.org/downloads/release/python-3120/) or use the Python Launcher:

```bash
py install 3.12.0
```

### 4. Run the install script

Open Git Bash in the project directory and run:

```bash
source install_4070_complete.bash
```

This script will:
- Create and activate a Python 3.12.0 virtual environment at `.venv`
- Install PyTorch and torchaudio 2.8.0cu128
- Verify CUDA 12.8 and cuDNN 9.x are detected correctly — if not, it will download the installers for you and exit
- Install WhisperX with all its dependencies.

> **Note:** If CUDA/cuDNN are not installed when you run the script, it will download the installers to the project directory and exit. Install them, then re-run the script.

## Running the app

With the virtual environment activated:

```bash
source .venv/Scripts/activate
python whisperx-gui.py
```

## Usage

1. Click **Add Files** to add audio or video files (`.mp4`, `.mkv`, `.mov`, `.wmv`, `.avi`, `.flv`, `.mp3`, `.wav`, `.aac`, `.flac`, `.ogg`)
2. Select a **Model** — `large-v2` is the most accurate, `tiny` is the fastest
3. Select the **Language** of the audio
4. Select a **Compute Type** — `float16` is recommended for CUDA
5. Click **Transcribe All**

Output files are saved to `transcripts/<filename>_<timestamp>/` and the folder opens automatically when transcription completes.
