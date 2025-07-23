#!/bin/bash

cd /workspace
comfy --here launch --background -- --listen 0.0.0.0 --port 3000 >> /dev/stdout 2>&1

# Ensure the process started
sleep 2
if ! pgrep -f "python.*main.py.*--port.*3000" > /dev/null; then
    echo "Failed to start ComfyUI"
    exit 1
fi
