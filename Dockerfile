FROM ubuntu:latest

WORKDIR /root

RUN apt --yes update && apt --yes install cloud-image-utils

ENTRYPOINT ["cloud-localds"]
