## Steps:

1. Install CUDA version 12.8 (Was current version in March 2025)

- Download (net installer): `wget https://developer.download.nvidia.com/compute/cuda/12.8.1/network_installers/cuda_12.8.1_windows_network.exe`
- Download (local installer): `wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_572.61_windows.exe`
- More options: `https://developer.nvidia.com/cuda-12-8-1-download-archive?target_os=Windows`

2. Install cuDNN version 9.20 (Current version as of 4/1/2026)

- Download: `wget https://developer.download.nvidia.com/compute/cudnn/9.20.0/local_installers/cudnn_9.20.0_windows_x86_64.exe`
- More options: `https://developer.nvidia.com/cudnn-downloads?target_os=Windows`

3. Set CUDA_PATH environment variable and add CuDNN bin folder path to the PATH.

4. Create a Python virtualenv at ./.venv and activate it (currently using 3.12.0):
   python -m venv .venv
   source ./.venv/Scripts/activate

5. Install torch and torchaudio builds from cu128 wheel.

6. Install whisperx.