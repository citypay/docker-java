#!/bin/bash

VER=`curl -s https://packages.ubuntu.com/bionic/amd64/openjdk-8-jre-headless | grep '<h1.*' | grep -ioE '8u[a-z0-9.-]*'`
BLD=`echo $VER | grep -ioE '[0-9a-z]*'`

echo "Building Docker Image for $VER:$BLD"

docker build --pull \
    --build-arg JAVA_UBUNTU_VERSION=$VER \
    --build-arg JAVA_VERSION=$BLD \
    -t citypay/java:1.8 \
    -t citypay/java:1.$BLD .

docker push -t citypay/java:1.$BLD