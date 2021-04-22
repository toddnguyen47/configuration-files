FROM alpine:latest AS builder
RUN apk update && apk add --no-cache \
  bash

FROM builder

RUN addgroup -g 1001 -S appuser \
  && adduser -u 1001 -S appuser -G appuser
USER appuser

RUN mkdir /home/appuser/.bash
COPY dotbash /home/appuser/.bash
COPY addBashRc.sh /home/appuser
COPY install.sh /home/appuser

WORKDIR /home/appuser
CMD ["bash"]
