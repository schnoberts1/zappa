FROM lambci/lambda:build

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

COPY yum.conf /etc/yum.conf
RUN yum -y clean all
# the touch and install is voodo todo with overlayfs, see https://github.com/moby/moby/issues/10180. 
RUN touch /var/lib/rpm/* && yum -y install 	python34-devel 
RUN touch /var/lib/rpm/* && yum -y install	python34-virtualenv 
RUN touch /var/lib/rpm/* && yum -y install	python34-pip 
RUN touch /var/lib/rpm/* && yum -y install	postgresql 
RUN touch /var/lib/rpm/* && yum -y install	postgresql-devel 
RUN touch /var/lib/rpm/* && yum -y install	mysql-devel
RUN touch /var/lib/rpm/* && yum -y install	gcc 
RUN touch /var/lib/rpm/* && yum -y install	lapack-devel 
RUN touch /var/lib/rpm/* && yum -y install	blas-devel 
RUN touch /var/lib/rpm/* && yum -y install	libyaml-devel 
RUN touch /var/lib/rpm/* && yum -y install	epel-release
RUN touch /var/lib/rpm/* && yum -y install	python34-setuptools 
RUN easy_install-3.4 pip
RUN pip3 install -U pip
RUN pip3 install -U zappa
RUN pip3 install -U virtualenv

WORKDIR /var/task

RUN virtualenv /var/venv && \
    source /var/venv/bin/activate && \
    pip3 install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

ENV AWS_DEFAULT_REGION eu-west-1

CMD ["zappa"]
