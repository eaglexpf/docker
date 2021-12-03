# build image
```
docker build -t <your image name> .
```
# push image
```
docker push  <your image name>
```

# pull image
```
docker pull nasus/php:bbc
```

```
bbc
|____bbc[代码目录]
|____conf
		|____mysql
		|____nginx
		|____license
|____cache
		|____mysql
		|____redis
```

# docker-compose.yaml
```
version: "3.3"

services:
  bbc-php:
    container_name: nasus/php:bbc
    volumes:
      - ./bbc:/var/www/html
      - ./conf/nginx:/etc/nginx/conf.d
      - ./conf/license:/zend_loader/license
    ports:
      - 80:80
  bbc-redis:
    container_name: bbc-redis
    image: redis
    volumes:
      - ./cache/redis:/data
    ports:
      - 6379:6379
  bbc-mysql:
    container_name: bbc-mysql
    image: mysql:5.6
    environment:
      MYSQL_ROOT_PASSWORD: 123456
    volumes:
      - ./cache/mysql:/var/lib/mysql
      - ./mysql/initdb.d:/docker-entrypoint-initdb.d
    ports:
      - 3306:3306

```

# /mysql/initdb.d/bbc.sql
```
create user bbc identified by '123456';

CREATE DATABASE IF NOT EXISTS bbc DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;

grant all privileges on bbc.* to bbc@'%' identified by '123456';
flush privileges;
```