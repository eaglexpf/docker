FROM golang:1.20 as build-stage

RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct \
	&& go install github.com/shadowsocks/go-shadowsocks2@latest

FROM alpine:3.17 as production-stage

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

COPY --from=build-stage /go/bin/* /usr/local/bin

EXPOSE 1080