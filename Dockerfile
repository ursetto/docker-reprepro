FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
       reprepro \
    && mkdir /repo/ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /repo/

CMD /usr/bin/reprepro
