FROM centos:7
MAINTAINER ThanhCL

ADD MariaDB.repo /etc/yum.repos.d/MariaDB.repo

#updated os, install some lib packages
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
  rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
  rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
  yum clean all && \
  yum install -y epel-release && \
  yum install -y MariaDB-server MariaDB-client telnet ntp  wget net-tools && \
  rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

#setup timezone
RUN echo "ZONE=\"Asia/Ho_Chi_Minh\"" > /etc/sysconfig/clock && \
  rm -rf /etc/localtime && \
  ln -s /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

RUN sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf

VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["mysqld"]

