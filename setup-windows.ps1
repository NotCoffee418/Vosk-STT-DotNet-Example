# Define model name
$MODEL_NAME = "vosk-model-en-us-0.42-gigaspeech"

# Define model directory and file paths
$MODEL_DIR = ".\models\vosk"
$MODEL_FILE_ZIP = Join-Path $MODEL_DIR "${MODEL_NAME}.zip"
$MODEL_URL = "https://alphacephei.com/vosk/models/${MODEL_NAME}.zip"

# Create the directory if it does not exist
if (!(Test-Path -Path $MODEL_DIR)) {
    New-Item -ItemType directory -Path $MODEL_DIR
}

# Download the Vosk model files if final model doesn't exist
$finalModelPath = Join-Path $MODEL_DIR "am\final.mdl"
if (!(Test-Path -Path $finalModelPath)) {
    Write-Host "Downloading ${MODEL_NAME}..."
    Invoke-WebRequest -Uri $MODEL_URL -OutFile $MODEL_FILE_ZIP
    Write-Host "Model file is available, extracting..."
    Expand-Archive -Path $MODEL_FILE_ZIP -DestinationPath $MODEL_DIR -Force
    Move-Item -Path (Join-Path $MODEL_DIR $MODEL_NAME\*) -Destination $MODEL_DIR -Force
    Remove-Item -Path (Join-Path $MODEL_DIR $MODEL_NAME) -Force
    Remove-Item -Path $MODEL_FILE_ZIP
} else {
    Write-Host "${MODEL_NAME} already exists. No download needed."
}

# Check if final model file is available
if (Test-Path -Path $finalModelPath) {
    Write-Host "Model downloaded and extracted correctly!"
} else {
    Write-Host "Model extraction failed or model file is missing!"
}
