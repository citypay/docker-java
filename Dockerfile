FROM ubuntu:18.04
LABEL maintainer="Gary Feltham <gary.feltham@citypay.com>"

COPY files/webupd8team_ubuntu_java.gpg /etc/apt/trusted.gpg.d/
COPY files/local_policy.jar /tmp/
COPY files/US_export_policy.jar /tmp/

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle


RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" > /etc/apt/sources.list.d/webupd8team-ubuntu-java-bionic.list && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default ca-certificates curl && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log} && \
    mv /tmp/local_policy.jar ${JAVA_HOME}/jre/lib/security/ && \
    mv /tmp/US_export_policy.jar ${JAVA_HOME}/jre/lib/security/ && \
    rm /etc/apt/trusted.gpg.d/webupd8team_ubuntu_java.gpg && \
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
           ./jre/lib/plugin.jar


