FROM jetbrains/teamcity-agent

USER root

RUN apt-get update


RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update
RUN apt-get install docker-ce docker-ce-cli containerd.io wget

RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz -O /tmp/openjdk11.tar.gz
RUN wget https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/openjdk-12.0.2_linux-x64_bin.tar.gz -O /tmp/openjdk12.tar.gz
RUN wget https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz -O /tmp/openjdk13.tar.gz
RUN wget https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_linux-x64_bin.tar.gz -O /tmp/openjdk14.tar.gz

RUN tar xfvz /tmp/openjdk11.tar.gz -C /opt/java/
RUN tar xfvz /tmp/openjdk12.tar.gz -C /opt/java/
RUN tar xfvz /tmp/openjdk13.tar.gz -C /opt/java/
RUN tar xfvz /tmp/openjdk14.tar.gz -C /opt/java/

RUN rm -f /tmp/openjdk*.gz

ENV JDK_11_64 /opt/java/jdk-11.0.2
ENV JDK_12_64 /opt/java/jdk-12.0.2
ENV JDK_13_64 /opt/java/jdk-13.0.2
ENV JDK_14_64 /opt/java/jdk-14.0.1

ENV JRE_HOME /opt/java/jdk-11.0.2
ENV JAVA_HOME /opt/java/jdk-11.0.2
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java ${JRE_HOME}/bin/java 1 && \
    update-alternatives --set java ${JRE_HOME}/bin/java && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1 && \
    update-alternatives --set javac ${JAVA_HOME}/bin/javac
