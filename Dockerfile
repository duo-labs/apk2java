FROM java:7

LABEL maintainer="Jordan Wright <jwright@duo.com>"

RUN apt-get update && apt-get install -y \
    wget \
    p7zip-full \
    unzip;

ENV JD_VERSION "1.4.0"
ENV JD_CLI_VERSION "0.9.1.Final"

RUN mkdir -p /opt
WORKDIR /opt

# Dex2Jar
RUN wget -q -O "/opt/dex2jar-2.0.zip" http://downloads.sourceforge.net/project/dex2jar/dex2jar-2.0.zip \
    && unzip dex2jar-2.0.zip \
    && chmod u+x dex2jar-2.0/*.sh \
    && rm -f dex2jar-2.0.zip 
ENV PATH $PATH:/opt/dex2jar-2.0

# JD-GUI
RUN wget -q -O "jd-gui.jar" "https://github.com/java-decompiler/jd-gui/releases/download/v$JD_VERSION/jd-gui-$JD_VERSION.jar"

# JD-CLI
RUN wget -q -O "jd-cli.zip" "https://github.com/kwart/jd-cmd/releases/download/jd-cmd-$JD_CLI_VERSION/jd-cli-$JD_CLI_VERSION-dist.zip"
RUN unzip jd-cli.zip

# Extract.sh
RUN wget -q -O "extract.sh" https://gist.githubusercontent.com/jordan-wright/a9d4265a84b7da0438664165f8d736c6/raw/d0148bc67cb154a2c4b46373115d9b6cdf7a3c69/extract.sh \
    && chmod +x extract.sh

VOLUME "/apk"

ENTRYPOINT ["./extract.sh"]