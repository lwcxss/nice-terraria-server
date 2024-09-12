FROM alpine:latest

# INSTALL DEPENDENCIES
RUN apk update 
RUN apk add wget unzip bash
RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del .build-dependencies

# PREPARE MAIN DIRECTORY
RUN mkdir /terraria
RUN mkdir /terraria/.tmp
VOLUME /terraria/worlds
COPY build_server_cfg_file.sh /terraria/.
RUN chmod +x /terraria/build_server_cfg_file.sh

# RUN START SCRIPT
CMD ["/terraria/build_server_cfg_file.sh"]
