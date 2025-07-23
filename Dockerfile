FROM runpod/base:0.7.0-ubuntu2204

ARG COMFYUI_VERSION

WORKDIR /workspace

# Setup Python and pip symlinks
RUN ln -sf /usr/bin/python3.10 /usr/bin/python \
&&  ln -sf /usr/bin/python3.10 /usr/bin/python3 \
&&  python -m pip install --upgrade pip \
&&  ln -sf /usr/local/bin/pip3.10 /usr/local/bin/pip

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124 \
&&  pip cache purge

# Install ComfyUI and ComfyUI Manager
RUN pip install comfy-cli \
&&  comfy --skip-prompt tracking disable \
&&  comfy --skip-prompt --here install --nvidia \
&&  pip cache purge

WORKDIR /workspace/ComfyUI

# Create user directory to store logs
RUN mkdir -p user

# Copy the README.md, extra_model_paths.yml and start script
COPY README.md /usr/share/nginx/html/README.md
COPY extra_model_paths.yml extra_model_paths.yml
COPY --chmod=755 pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]
