# syntax=docker/dockerfile:1.6

ARG UBUNTU_VERSION=24.04
ARG NODE_VERSION=20.11.1
ARG ARCH=linux-x64

FROM ubuntu:${UBUNTU_VERSION} AS base

# Minimal deps for downloading + verifying Node tarball
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gnupg \
      xz-utils; \
    rm -rf /var/lib/apt/lists/*

FROM base AS download_and_verify_node
ARG NODE_VERSION
ARG ARCH

WORKDIR /tmp

# Download node + checksums and verify tarball SHA256
RUN set -eux; \
    curl -fsSLO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${ARCH}.tar.xz"; \
    curl -fsSLO "https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt"; \
    grep " node-v${NODE_VERSION}-${ARCH}\.tar\.xz$" SHASUMS256.txt | sha256sum -c -

# Unpack to a stable path
RUN set -eux; \
    mkdir -p /opt/node; \
    tar -xJf "node-v${NODE_VERSION}-${ARCH}.tar.xz" -C /opt/node --strip-components=1; \
    /opt/node/bin/node -v; \
    /opt/node/bin/npm -v

FROM base AS dev
ARG NODE_VERSION
ARG ARCH

# Install node into /usr/local (standard PATH)
COPY --from=download_and_verify_node /opt/node/ /usr/local/

# Optional: ensure corepack is available (yarn/pnpm)
RUN set -eux; \
    node -v; \
    npm -v; \
    corepack enable

WORKDIR /workspace
CMD ["bash"]

FROM dev as codex
RUN set -eux; npm install -g @openai/codex

FROM dev as cline
RUN set -eux; npm install -g cline
