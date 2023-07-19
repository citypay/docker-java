#!/bin/bash

export DOCKER_CONTENT_TRUST=1
VER=`curl -s https://packages.ubuntu.com/jammy/amd64/openjdk-8-jre-headless | grep '<h1.*' | grep -ioE '8u[~a-z0-9.-]*'`
BLD=`echo $VER | sed 's/\-.*//g'`

echo "Building Docker Image for $VER:$BLD"

docker build --platform linux/amd64 --no-cache --pull \
    --build-arg JAVA_UBUNTU_VERSION=$VER \
    --build-arg JAVA_VERSION=$BLD \
    -t citypay/java:latest \
    -t citypay/java:1.8 \
    -t citypay/java:1.$BLD . && \
docker push docker.io/citypay/java:latest && \
docker push docker.io/citypay/java:1.8 && \
docker push docker.io/citypay/java:1.$BLD && \
docker trust sign docker.io/citypay/java:latest && \
docker trust sign docker.io/citypay/java:1.8 && \
docker trust sign docker.io/citypay/java:1.$BLD

