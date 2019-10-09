FROM ubuntu:18.04
LABEL maintainer="Gary Feltham <gary.feltham@citypay.com>"

# COPY files/webupd8team_ubuntu_java.gpg /etc/apt/trusted.gpg.d/
COPY UnlimitedJCEPolicyJDK8/*.jar /tmp/

ARG JAVA_VERSION
ARG JAVA_UBUNTU_VERSION

ENV JAVA_VERSION=1.8u222
ENV JAVA_UBUNTU_VERSION=8u222-b10-1ubuntu1~18.04.1

ENV LANG C.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

#RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" > /etc/apt/sources.list.d/webupd8team-ubuntu-java-bionic.list && \
#    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates-java curl \
        openjdk-8-jre-headless=$JAVA_UBUNTU_VERSION && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log} && \
    echo $JAVA_HOME && \
    mv /tmp/local_policy.jar ${JAVA_HOME}/jre/lib/security/ && \
    mv /tmp/US_export_policy.jar ${JAVA_HOME}/jre/lib/security/ && \
    cd ${JAVA_HOME} && rm -rf ./*src.zip \
           ./lib/missioncontrol \
           ./lib/visualvm \
           ./lib/*javafx* \
           ./jre/plugin \
           ./jre/bin/javaws \
           ./jre/bin/jjs \
           ./jre/bin/orbd \
           ./jre/bin/pack200 \
           ./jre/bin/policytool \
           ./jre/bin/rmid \
           ./jre/bin/rmiregistry \
           ./jre/bin/servertool \
           ./jre/bin/tnameserv \
           ./jre/bin/unpack200 \
           ./jre/lib/javaws.jar \
           ./jre/lib/deploy* \
           ./jre/lib/desktop \
           ./jre/lib/*javafx* \
           ./jre/lib/*jfx* \
           ./jre/lib/amd64/libdecora_sse.so \
           ./jre/lib/amd64/libprism_*.so \
           ./jre/lib/amd64/libfxplugins.so \
           ./jre/lib/amd64/libglass.so \
           ./jre/lib/amd64/libgstreamer-lite.so \
           ./jre/lib/amd64/libjavafx*.so \
           ./jre/lib/amd64/libjfx*.so \
           ./jre/lib/ext/jfxrt.jar \
           ./jre/lib/ext/nashorn.jar \
           ./jre/lib/oblique-fonts \
           ./jre/lib/plugin.jar && java -version


