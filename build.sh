#!/bin/bash

set -euxo pipefail

BUILD_MODE=${1:-build}

BUILD_AUTO_TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-list --count HEAD)
BUILD_TAG=${BUILD_TAG:-${BUILD_AUTO_TAG}}
BUILD_DOCKER_BUILDER=${BUILD_DOCKER_BUILDER:-container}

BUILD_PLATFORM=linux/amd64,linux/arm64

echo "Building ilharp/cordis-base:${BUILD_TAG} using builder: ${BUILD_DOCKER_BUILDER}\n\n"

case ${BUILD_MODE} in
  "push")
    if [ "$BUILD_TAG" = "$BUILD_AUTO_TAG" ]
    then
      docker buildx build \
        --push \
        --builder=${BUILD_DOCKER_BUILDER} \
        --platform ${BUILD_PLATFORM} \
        -t ghcr.io/ilharp/cordis-base:${BUILD_TAG} \
        -t ilharp/cordis-base:${BUILD_TAG} \
        .
    else
      docker buildx build \
        --push \
        --builder=${BUILD_DOCKER_BUILDER} \
        --platform ${BUILD_PLATFORM} \
        -t ghcr.io/ilharp/cordis-base:${BUILD_TAG} \
        -t ghcr.io/ilharp/cordis-base:latest \
        -t ilharp/cordis-base:${BUILD_TAG} \
        -t ilharp/cordis-base:latest \
        .
    fi
    ;;
  *)
    docker buildx build \
      --builder=${BUILD_DOCKER_BUILDER} \
      --platform ${BUILD_PLATFORM} \
      -t ilharp/cordis-base:${BUILD_TAG} \
      .
    ;;
esac
