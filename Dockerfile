FROM jetbrains/teamcity-agent

USER root

RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN mkdir /opt/java/jdk-11 /opt/java/jdk-12 /opt/java/jdk-13 /opt/java/jdk-14

RUN curl -fsSL https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x64_linux_11.0.8_10.tar.gz | tar -xvzf - -C /opt/java/jdk-11 --strip-components=1 
RUN curl -fsSL https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/openjdk-12.0.2_linux-x64_bin.tar.gz | tar -xvzf - -C /opt/java/jdk-12 --strip-components=1 
RUN curl -fsSL https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz | tar -xvzf - -C /opt/java/jdk-13 --strip-components=1 
RUN curl -fsSL https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_linux-x64_bin.tar.gz | tar -xvzf - -C /opt/java/jdk-14 --strip-components=1 

ENV JDK_11_64 /opt/java/jdk-11
ENV JDK_12_64 /opt/java/jdk-12
ENV JDK_13_64 /opt/java/jdk-13
ENV JDK_14_64 /opt/java/jdk-14

ENV JRE_HOME /opt/java/jdk-11
ENV JAVA_HOME /opt/java/jdk-11
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java ${JRE_HOME}/bin/java 1 && \
    update-alternatives --set java ${JRE_HOME}/bin/java && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1 && \
    update-alternatives --set javac ${JAVA_HOME}/bin/javac
