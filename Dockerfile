FROM node:lts

RUN apt-get update && apt-get install -y \
    sudo \
    wget

COPY . /app
WORKDIR /app
ENV VULN_REGEX_DETECTOR_ROOT /app

# configure calls apt-get install, so ensure it has fresh package list
RUN apt-get update && \
    JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 ./configure
