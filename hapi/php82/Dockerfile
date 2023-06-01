FROM nasus/hyperf:82

COPY --from=golang:1.20.4-alpine3.18 /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct