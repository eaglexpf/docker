FROM memcached

USER root

RUN apt-get update && apt-get install -y --no-install-recommends sasl2-bin && rm -rf /var/lib/apt/lists/*

CMD echo $PASSWORD | saslpasswd2 -c $USERNAME -p && exec memcached -S -u root