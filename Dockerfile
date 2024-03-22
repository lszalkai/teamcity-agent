FROM jetbrains/teamcity-agent:2023.11.4-linux-sudo

USER root

ARG DOCKER_COMPOSE_VERSION=2.25.0

ARG JDK_8_URL=https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.tar.gz
ARG JDK_11_URL=https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
ARG JDK_17_URL=https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz
ARG JDK_21_URL=https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.tar.gz


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN mkdir -p /opt/java/jdk-8  && curl -fsSL $JDK_8_URL | tar -xvzf - -C /opt/java/jdk-8 --strip-components=1  && \
    mkdir /opt/java/jdk-11 && curl -fsSL $JDK_11_URL | tar -xvzf - -C /opt/java/jdk-11 --strip-components=1  && \
    mkdir /opt/java/jdk-17 && curl -fsSL $JDK_17_URL | tar -xvzf - -C /opt/java/jdk-17 --strip-components=1  && \
    mkdir /opt/java/jdk-21 && curl -fsSL $JDK_21_URL | tar -xvzf - -C /opt/java/jdk-21 --strip-components=1 && \
    rm -rf *.tar.gz

ENV JDK_8_64 /opt/java/jdk-8
ENV JDK_11_64 /opt/java/jdk-11
ENV JDK_17_64 /opt/java/jdk-17
ENV JDK_21_64 /opt/java/jdk-21

ENV JRE_HOME /opt/java/jdk-21
ENV JAVA_HOME /opt/java/jdk-21
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java ${JRE_HOME}/bin/java 1 && \
    update-alternatives --set java ${JRE_HOME}/bin/java && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1 && \
    update-alternatives --set javac ${JAVA_HOME}/bin/javac
