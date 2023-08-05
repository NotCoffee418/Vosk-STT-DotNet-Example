#!/bin/bash

# Define model name
MODEL_NAME="vosk-model-en-us-0.42-gigaspeech"

# Define model directory and file paths
MODEL_DIR=./models/vosk
MODEL_FILE_ZIP=${MODEL_DIR}/${MODEL_NAME}.zip
MODEL_URL="https://alphacephei.com/vosk/models/${MODEL_NAME}.zip"

# Enzure unzip is installed
if ! command -v unzip &> /dev/null
then
    echo "unzip could not be found"
    sudo apt-get install unzip -y
fi

# Create the directory if it does not exist
mkdir -p ${MODEL_DIR}

# Download the Vosk model files if final model doesn't exist
if [ ! -f ${MODEL_DIR}/am/final.mdl ]; then
    echo "Downloading ${MODEL_NAME}..."
    curl -Lo ${MODEL_FILE_ZIP} ${MODEL_URL}
    echo "Model file is available, extracting..."
    unzip -q ${MODEL_FILE_ZIP} -d ${MODEL_DIR} && mv ${MODEL_DIR}/${MODEL_NAME}/* ${MODEL_DIR} && rmdir ${MODEL_DIR}/${MODEL_NAME}
    rm ${MODEL_FILE_ZIP}
else
    echo "${MODEL_NAME} already exists. No download needed."
fi

# Check if final model file is available
if [ -f ${MODEL_DIR}/am/final.mdl ]; then
    echo "Model downloaded and extracted correctly!"
else
    echo "Model extraction failed or model file is missing!"
fi
