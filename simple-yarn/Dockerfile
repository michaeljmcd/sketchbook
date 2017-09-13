FROM ubuntu
USER root

RUN useradd -ms /bin/bash hadoopuser
RUN echo "hadoopuser:hadoopuser" | chpasswd
RUN usermod -a -G sudo hadoopuser

RUN apt-get update;apt-get install -y openjdk-8-jdk-headless openssh-server sudo less
WORKDIR /opt
ADD /hadoop-3.0.0-alpha3 /opt/hadoop-3.0.0-alpha3
ADD mapred-site.xml /opt/hadoop-3.0.0-alpha3/etc/hadoop/
ADD yarn-site.xml /opt/hadoop-3.0.0-alpha3/etc/hadoop/
ADD startup.sh /opt/
RUN chown -R hadoopuser /opt/hadoop-3.0.0-alpha3

USER hadoopuser

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_COMMON_HOME=/opt/hadoop-3.0.0-alpha3/
ENV HADOOP_HDFS_HOME=/opt/hadoop-3.0.0-alpha3/
ENV HADOOP_YARN_HOME=/opt/hadoop-3.0.0-alpha3/
ENV HDFS_NAMENODE_USER=hadoopuser
ENV HDFS_DATANODE_USER=hadoopuser
ENV HDFS_SECONDARYNAMENODE_USER=hadoopuser

EXPOSE 8088
ENTRYPOINT  /opt/startup.sh
