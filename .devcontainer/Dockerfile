FROM node:24-bookworm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        git-lfs \
        curl \
        wget \
        ca-certificates \
        openssh-client \
        nano \
        && \
    rm -rf /var/lib/apt/lists/*

USER node
