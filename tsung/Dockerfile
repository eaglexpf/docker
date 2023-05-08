FROM centos:7

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV ERLANG_VERSION=24.3 \
	PERL_VERSION=5.34.1 \
	TSUNG_VERSION=1.7.0 \
	TEMPLATE_VERSION=Toolkit-3.100 \
	ERLANG_HOME=/usr/local/lib/erlang \
	TSUNG_HOME=/usr/local/lib/tsung \
	PATH=$PATH:${ERLANG_HOME}/bin:${TSUNG_HOME}/bin

RUN yum install -y wget \
	&& mkdir /download && cd /download \
	# install erlang
	# && wget http://erlang.org/download/otp_src_${ERLANG_VERSION}.tar.gz \
	&& wget http://mirrors.8ac.cc:5080/tsung/otp_src_${ERLANG_VERSION}.tar.gz \
	&& yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel unixODBC-devel libtool libtool-ltdl-devel \
	&& tar xzf otp_src_${ERLANG_VERSION}.tar.gz \
	&& cd otp_src_${ERLANG_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	&& cd ../ \
	# install perl
	# && wget https://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz \
	&& wget https//mirrors.8ac.cc:5080/tsung/perl-${PERL_VERSION}.tar.gz \
	&& yum remove -y perl && yum -y install gcc cpan \
	&& tar xzf perl-${PERL_VERSION}.tar.gz \
	&& cd perl-${PERL_VERSION} \
    && ./Configure -des \
	&& make \
	&& make install \
	&& cd ../ \
	# install tsung
	# && wget http://tsung.erlang-projects.org/dist/tsung-${TSUNG_VERSION}.tar.gz \
	&& wget https//mirrors.8ac.cc:5080/tsung/ptsung-${TSUNG_VERSION}.tar.gz \
	&& tar xzf tsung-${TSUNG_VERSION}.tar.gz \
	&& cd tsung-${TSUNG_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	&& cd ../ \
	# install Template
	&& yum -y install gnuplot perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker perl-Template-Toolkit \
	# && wget https://www.cpan.org/modules/by-module/Template/Template-${TEMPLATE_VERSION}.tar.gz \
	&& wget https//mirrors.8ac.cc:5080/tsung/Template-${TEMPLATE_VERSION}.tar.gz \
	&& tar xzf Template-${TEMPLATE_VERSION}.tar.gz \
	&& cd Template-${TEMPLATE_VERSION} \
	&& perl Makefile.PL \
	&& make \
	&& make install \
	&& cd ../ \
	# install nginx
	&& rpm -Uvh  http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm \
	&& yum install -y nginx  \
	&& yum clean all \
	&& rm -rf /download/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
