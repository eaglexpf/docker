FROM nasus/hyperf:80

COPY --from=golang:1.20.3-alpine3.16 /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct