FROM node:10.9.0-slim@sha256:7a71fcfbe8d721ceb620f89fd6abf7f3a586346f40de5293357713b535b6b664

# Adds backports
RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list

# Installs git, unoconv and chinese fonts
RUN apt-get update && apt-get -t jessie-backports -y install \
    git \
    unoconv=0.7-1.1~bpo8+1 \
    ttf-wqy-zenhei \
    fonts-arphic-ukai \
    fonts-arphic-uming \
&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002
