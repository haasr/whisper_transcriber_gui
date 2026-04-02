#!/bin/bash -

wget https://github.com/BtbN/FFmpeg-Builds/releases/download/autobuild-2024-10-31-12-59/ffmpeg-n6.1.2-11-g7d79d0a43b-win64-gpl-shared-6.1.zip

# Unzip, delete zip, change name to "ffmpeg":
unzip ffmpeg*.zip; rm ffmpeg*.zip; mv ffmpeg* ffmpeg

# Move to /c (don't do this prior; gets permission denied in Git Bash):
mv ffmpeg /c

# Exports
export PATH="$PATH:/c/ffmpeg/bin"
export INCLUDE="C:\\ffmpeg\\include"
export LIB="C:\\ffmpeg\\lib"

echo "Check that C:\ffmpeg\bin is in your path and that INCLUDE and LIB are not null"
echo "You can set them manually in Git Bash like this:"
echo 'export PATH="$PATH:/c/ffmpeg/bin"'
echo 'export INCLUDE="C:\\ffmpeg\\include"'
echo 'export LIB="C:\\ffmpeg\\lib"'
echo "Or you can set them manually through Windows:"
echo "- Add C:\ffmpeg\bin to your Path"
echo "- Set env var INCLUDE to C:\ffmpeg\include"
echo "- Set env var LIB to C:\ffmpeg\lib"
