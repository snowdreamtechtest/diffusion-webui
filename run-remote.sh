#!/bin/sh

export DIFFUSION="/volume1/docker/diffusion"
# export DIFFUSION="/Users/snowdream/Docker/diffusion"
export MODELS="${DIFFUSION}/models"
export OUTPUTS="${DIFFUSION}/outputs"
export EXTENSIONS="${DIFFUSION}/extensions"
export CONFIGS="${DIFFUSION}/configs"
export OTHERS="${DIFFUSION}/others"

create_dir_if_not_exist() {
    dir="$1"

    if [ ! -d "$dir" ]; then
        {
            mkdir -p "$dir"
        }
    fi
}

prepare(){
    create_dir_if_not_exist $DIFFUSION
    create_dir_if_not_exist $MODELS
    create_dir_if_not_exist $OUTPUTS
    create_dir_if_not_exist $EXTENSIONS
    create_dir_if_not_exist $CONFIGS
    create_dir_if_not_exist $OTHERS
}

prepare

# docker run
docker run --gpus all --restart always --name diffusion_webui -d \
    -v ${MODELS}:/app/models \
    -v ${OUTPUTS}:/app/outputs \
    -v ${EXTENSIONS}:/app/extensions \
    -v ${CONFIGS}:/app/configs \
    -v ${OTHERS}:/temp/others \
    -p 7860:7860 \
    ghcr.io/snowdreamtechtest/diffusion-webui:latest
