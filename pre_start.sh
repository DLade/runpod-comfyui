#!/bin/bash

cd /home/comfyui
source .venv/bin/activate

nohup python main.py --listen --port 3000 >> /dev/stdout 2>&1 &

# Ensure the process started
sleep 2
if ! pgrep -f "python.*main.py.*--port.*3000" > /dev/null; then
    echo "Failed to start ComfyUI"
    exit 1
fi
