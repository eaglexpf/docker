FROM centos:7

LABEL maintainer="eaglexpf <1121252990@qq.com>"

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/altarch/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -e 's|^#baseurl=http://mirror.centos.org/$contentdir/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo && yum makecache && yum update -y

ENV ERLANG_VERSION=24.3 \
	PERL_VERSION=5.34.1 \
	TSUNG_VERSION=1.7.0 \
	TEMPLATE_VERSION=Toolkit-3.100

RUN yum install -y wget \
	# install erlang
	&& wget http://erlang.org/download/otp_src_${ERLANG_VERSION}.tar.gz \
	&& yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel unixODBC-devel libtool libtool-ltdl-devel \
	&& tar xzf otp_src_${ERLANG_VERSION}.tar.gz \
	&& cd otp_src_${ERLANG_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	# install perl
	&& wget https://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz \
	&& yum remove -y perl && yum -y install gcc cpan \
	&& tar xzf perl-${PERL_VERSION}.tar.gz \
	&& cd perl-${PERL_VERSION} \
    && ./Configure -des \
	&& make \
	&& make test \
	&& make install \
	# install tsung
	&& wget http://tsung.erlang-projects.org/dist/tsung-${TSUNG_VERSION}.tar.gz \
	&& tar xzf tsung-${TSUNG_VERSION}.tar.gz \
	&& cd tsung-${TSUNG_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	# install Template
	&& yum -y install gnuplot perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker perl-Template-Toolkit \
	&& wget https://www.cpan.org/modules/by-module/Template/Template-${TEMPLATE_VERSION}.tar.gz \
	&& tar xzf Template-${TEMPLATE_VERSION}.tar.gz \
	&& cd Template-${TEMPLATE_VERSION} \
	&& perl Makefile.PL \
	&& make \
	&& make test \
	&& make install \
	# install nginx
	&& rpm -Uvh  http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm \
	&& yum install -y nginx  

ENV ERLANG_HOME /usr/local/lib/erlang 
ENV	TSUNG_HOME /usr/local/lib/tsung 
ENV	PATH $PATH:${ERLANG_HOME}/bin:${TSUNG_HOME}/bin

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
