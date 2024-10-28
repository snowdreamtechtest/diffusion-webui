FROM bobzhao1210/diffusion-webui:latest

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Debian Base Image" \
    org.opencontainers.image.description="Docker Images for Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/debian" \
    org.opencontainers.image.base.name="snowdreamtech/debian:latest" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/debian" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="12.7" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/debian"

ENV DEBIAN_FRONTEND=noninteractive \
    # keep the docker container running
    KEEPALIVE=1 \
    # Ensure the container exec commands handle range of utf8 characters based of
    # default locales in base image (https://github.com/docker-library/docs/tree/master/debian#locales)
    LANG=C.UTF-8 

WORKDIR /app

# RUN set -eux \
#     && apt-get -qqy update  \
#     && apt-get -qqy install --no-install-recommends \ 
#     procps \
#     sudo \
#     vim \ 
#     unzip \
#     tzdata \
#     openssl \
#     wget \
#     curl \
#     iputils-ping \
#     lsof \
#     apt-transport-https \
#     ca-certificates \                                                                                                                                                                                                      
#     && update-ca-certificates\
#     && apt-get -qqy --purge autoremove \
#     && apt-get -qqy clean \
#     && rm -rf /var/lib/apt/lists/* \
#     && rm -rf /tmp/* \
#     && rm -rf /var/tmp/* \
#     && echo 'export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> /etc/bash.bashrc 

RUN sed -i -E "s/#?export\sCOMMANDLINE_ARGS=\"\"/export COMMANDLINE_ARGS=\"--lowvram --precision full --no-half --skip-torch-cuda-test\"/g" webui-user.sh \
    && sed -i -E "s/#?set\sCOMMANDLINE_ARGS=/set COMMANDLINE_ARGS=--lowvram --precision full --no-half --skip-torch-cuda-test/g" webui-user.bat

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["python webui.py"]
