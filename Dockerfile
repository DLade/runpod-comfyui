FROM runpod/pytorch:0.7.0-cu1241-torch260-ubuntu2004 AS runpod_base

# update BASE image
RUN apt update \
&&  apt upgrade --yes

# Cleanup
RUN apt autoremove --yes && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/*
    
# Setup Python and pip symlinks
RUN ln -sf /usr/bin/python3.10 /usr/bin/python \
&&  ln -sf /usr/bin/python3.10 /usr/bin/python3 \
&&  ln -sf /usr/local/bin/pip3.10 /usr/local/bin/pip

# --------------------------------------------------
FROM runpod_base AS comfyui

ENV COMFYUI_HOME=/home/comfyui

SHELL ["/bin/bash", "-c"]

WORKDIR $COMFYUI_HOME

# Get ComfyUI and ComfyUI Manager
RUN git clone --single-branch --branch master --depth 1 --no-tags https://github.com/comfyanonymous/ComfyUI.git . && \
    git clone --single-branch --branch main --depth 1 --no-tags https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager
    
# setup environment and tools
RUN python -m venv --system-site-packages .venv \
&&  source .venv/bin/activate \
&&  python -m pip install --upgrade pip 

# install ComfyUI and Manager as standalone with all packages
RUN source .venv/bin/activate \
&&  pip install -r requirements.txt \
&&  pip install -r custom_nodes/ComfyUI-Manager/requirements.txt 

# Cleanup
RUN source .venv/bin/activate \
&&  pip cache purge

# Create user directory to store logs
RUN mkdir -p user

# Copy the README.md, extra_model_paths.yml and start script
COPY README.md /usr/share/nginx/html/README.md
COPY --chmod=755 pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]
