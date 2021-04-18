FROM node:lts

RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    vim

COPY . /app
WORKDIR /app
ENV VULN_REGEX_DETECTOR_ROOT /app

# if we are running as a submodule of anouther repo, we can still be configured.
RUN rm -rf .git && git init && ./deploy/update_submodules.sh

# configure calls apt-get install, so ensure it has fresh package list
RUN apt-get update && \
    JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 ./configure
