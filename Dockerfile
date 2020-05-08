FROM openjdk:8

LABEL maintainer="Jordan Wright <jwright@duo.com>"

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    p7zip-full;

ENV JD_CLI_VERSION "1.0.1.Final"

RUN mkdir -p /opt
WORKDIR /opt

# Dex2Jar
RUN wget -q -O "dex2jar-2.1.zip" https://github.com/pxb1988/dex2jar/files/1867564/dex-tools-2.1-SNAPSHOT.zip \
    && unzip dex2jar-2.1.zip \
    && chmod u+x dex-tools-2.1-SNAPSHOT/*.sh \
    && rm -f dex2jar-2.1.zip
ENV PATH $PATH:/opt/dex-tools-2.1-SNAPSHOT

# JD-CLI
RUN wget -q -O "jd-cli.zip" "https://github.com/kwart/jd-cmd/releases/download/jd-cmd-$JD_CLI_VERSION/jd-cli-$JD_CLI_VERSION-dist.zip"
RUN unzip jd-cli.zip

# Extract.sh
COPY extract.sh .
RUN chmod +x extract.sh

VOLUME "/apk"

ENTRYPOINT ["./extract.sh"]
