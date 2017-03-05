FROM centos:centos6
MAINTAINER	The CentOS PROJECT

#### Python2.7 installation

# Update and clean yum cache
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum groupinstall -y "Development Tools"
RUN yum install -y xz-libs sudo gcc zlib-dev glibc glibc-devel glibc-common build-essential openssl-devel sqlite-devel bzip2-devel wget
WORKDIR /opt
RUN wget --no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
RUN tar xf Python-2.7.6.tar.xz
RUN cd /opt/Python-2.7.6; ./configure --prefix=/usr/local
RUN cd /opt/Python-2.7.6; make && sudo make altinstall
RUN ln -s /usr/local/bin/python2.7 /usr/local/bin/python

#### MongoDB installation with repo

RUN yum -y install epel-release; yum clean all
ADD mongodb-org-3.4.repo /etc/yum.repos.d/
RUN yum -y install mongodb-org

# Create Data dir for mongo.
RUN mkdir -p /data/db

# Expose Mongo ports 
EXPOSE 27017

#### Apache Tom 7 installation

# Install wget and tar
RUN yum install -y wget tar

# Download and install JDK
RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz; pwd
RUN cd /opt;tar xvf jdk-7u55-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.55/bin/java 2

# Download and install Apache Tom 7 
RUN cd /tmp;wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.42/bin/apache-tomcat-7.0.42.tar.gz 
RUN cd /tmp;tar xvf apache-tomcat-7.0.42.tar.gz
RUN cd /tmp;mv apache-tomcat-7.0.42 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7
ENV JAVA_HOME /opt/jdk1.7.0_55

# Expose Tomcat's port 8080
EXPOSE 8080

# Add startup script.
ADD start.sh /bin/start.sh

# Change permissions
RUN chmod 755 /bin/start.sh
# Run startup script
ENTRYPOINT ["./bin/start.sh"]
