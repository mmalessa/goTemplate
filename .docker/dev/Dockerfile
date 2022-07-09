ARG BASE_GO_IMAGE
FROM ${BASE_GO_IMAGE} AS base

RUN apk update && apk upgrade
RUN apk add --no-cache bash git openssh autoconf automake libtool gettext gettext-dev make g++ texinfo curl

RUN   mkdir /go/pkg
RUN   chmod a+rwx /go/pkg

ARG DEVELOPER_UID
RUN adduser -s /bin/sh -u ${DEVELOPER_UID} -D developer
USER developer

ARG APP_HOME
WORKDIR /go/src/${APP_HOME}
