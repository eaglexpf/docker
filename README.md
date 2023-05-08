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

# centos7替换源 
# ARM架构
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-altarch-7.repo \
    && yum makecache
# X86 X64架构
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo \
    && yum makecache


# debian替换源 X86架构
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update


```

```
docker login

docker build -t [name] .
docker push [name]

docker run -it [name] /bin/bash
```