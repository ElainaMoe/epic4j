FROM openjdk:8-jdk-alpine
MAINTAINER huisunan

RUN echo "http://mirrors.aliyun.com/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.12/main" >> /etc/apk/repositories \
    && apk upgrade -U -a \
    && apk add \
    libstdc++ \
    chromium \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    font-noto-emoji \
    wqy-zenhei \
    && rm -rf /var/cache/* \
    && mkdir /var/cache/apk
COPY local.conf /etc/fonts/local.conf


RUN mkdir -p /opt/epic4j \
    && adduser -D chrome \
    && chown -R chrome:chrome /opt/epic4j

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# Run Chrome as non-privileged
USER chrome

COPY target/epic4j.jar /opt/epic4j/epic4j.jar
COPY start.sh /opt/epic4j/start.sh
WORKDIR /opt/epic4j


CMD /opt/epic4j/start.sh