# docker

## 运行一个临时容器用来测试
```
docker run --rm -it <image_name> <command>
```
例如:
```
docker run --rm -it alpine:3.17 /bin/sh
```

## 替换源

```
# alpine替换源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update

# centos7替换源 ARM架构
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/altarch/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -e 's|^#baseurl=http://mirror.centos.org/$contentdir/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo && yum makecache

# debian替换源 X86架构
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update

# centos8替换国内源

cd /etc/yum.repos.d/ && \
mkdir backup && mv *repo backup/ && \
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo && \
sed -i -e"s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-* && \
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-* && \
yum clean all && yum makecache
```

```
docker login

docker build -t [name] .
docker push [name]

docker run -it [name] /bin/bash
```