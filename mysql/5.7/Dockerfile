FROM mysql:5.7

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

RUN echo "max_allowed_packet=1024M" >> /etc/mysql/mysql.conf.d/mysqld.cnf \
	&& echo "lower_case_table_names=1" >> /etc/mysql/mysql.conf.d/mysqld.cnf

CMD ["mysqld"]