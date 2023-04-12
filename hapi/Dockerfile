FROM nasus/hyperf:8.1-alpine-3.17

COPY --from=golang:1.20.3-alpine3.17 /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go env -w GOPROXY=https://goproxy.cn,direct