#!/bin/bash -

workdir=$(pwd)

if [ -d ".venv" ]; then
    echo "Found existing .venv, activating..."
    source ./.venv/Scripts/activate
    python_version=$(python --version 2>&1)
    if [[ "$python_version" != *"3.12"* ]]; then
        echo "Error: .venv is not using Python 3.12. Found: $python_version"
        echo "Delete .venv and re-run this script."
        exit 1
    fi
    echo "Activated .venv ($python_version)"
else
    echo "No .venv found, creating one with Python 3.12.0..."
    py -3.12.0 -m venv .venv
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create .venv. Make sure Python 3.12.0 is installed."
        echo "Install it with: py install 3.12.0"
        exit 1
    fi
    source ./.venv/Scripts/activate
    echo "Created and activated .venv"
fi

# Install torch versions from CUDA 12.8 wheel:
echo "Installing Pytorch builds for CUDA v12.8.."
pip install torch~=2.8.0 torchaudio~=2.8.0 --index-url https://download.pytorch.org/whl/cu128

# Now check CUDA, cuDNN version:
echo "Checking CUDA and cuDNN installation..."
cuda_path="${CUDA_PATH}"
cuda_available=$(python -c "import torch; print(torch.cuda.is_available())" 2>/dev/null)
cuda_version=$(python -c "import torch; print(torch.version.cuda)" 2>/dev/null)
cudnn_major=$(python -c "import torch; print(torch.backends.cudnn.version()//10000)" 2>/dev/null)
gpu_name=$(python -c "import torch; print(torch.cuda.get_device_name(0))" 2>/dev/null)

echo "  CUDA_PATH:                      $cuda_path"
echo "  torch.version.cuda:             $cuda_version"
echo "  torch.cuda.is_available():      $cuda_available"
echo "  torch.cuda.get_device_name(0):  $gpu_name"
echo "  torch.backends.cudnn.version(): $cudnn_major"

if [[ "$cuda_available" == "True" ]] && [[ "$cuda_path" == *"v12.8"* ]] && [[ "$cudnn_major" == "9" ]]; then
    echo "CUDA 12.8 and cuDNN 9.x verified. Continuing..."
elif [[ -z "$cuda_path" ]] || [[ "$cuda_available" == "False" ]]; then
    echo ""
    echo "CUDA not found. Download the installers with wget or curl:"
    echo "https://developer.download.nvidia.com/compute/cuda/12.8.1/network_installers/cuda_12.8.1_windows_network.exe"
    echo "wget https://developer.download.nvidia.com/compute/cudnn/9.20.0/local_installers/cudnn_9.20.0_windows_x86_64.exe"
    echo ""
    echo "Install CUDA 12.8 and cuDNN 9.x, then re-run this script."
    exit 0
else
    echo ""
    echo "Unexpected CUDA/cuDNN versions. Expected CUDA 12.6 and cuDNN 9.5.1 (90501)."
    echo "  CUDA_PATH should contain 'v12.6'"
    echo "  torch.cuda.is_available() should be True"
    echo "  torch.backends.cudnn.version() should be 90501"
    echo "Please resolve manually, then re-run this script."
    exit 1
fi

# If this stops working in future, try pip install whisperx@git+https://github.com/m-bain/whisperx.git@4a6477e5e52ad516faab5363bdafbfa9840aec5e
# since that is the version tested on 4/1/2026.
pip install whisperx

echo "Done"