FROM centos/httpd
ENV TIMEZONE UTC

RUN echo "${TIMEZONE}" > /etc/timezone

RUN yum update -y && \
    yum install -y wget postgresql php php-pear php php-cli php-common php-devel php-gd php-mbstring php-mcrypt php-mysql php-snmp php-pdo_pgsql

ENV TESTLINK_VERSION 1.9.19

RUN wget -q https://github.com/TestLinkOpenSourceTRMS/testlink-code/archive/$TESTLINK_VERSION.tar.gz -O $TESTLINK_VERSION.tar.gz &&\
    tar zxvf $TESTLINK_VERSION.tar.gz && \
    mv testlink-code-$TESTLINK_VERSION /var/www/html/testlink/ && \
    chmod -R 777 /var/www/html/testlink/ && \
    rm -rf $TESTLINK_VERSION.tar.gz

RUN sed -i 's/^/#&/g' /etc/httpd/conf.d/welcome.conf
RUN sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/httpd/conf/httpd.conf

COPY config_db.inc.php /var/www/html/testlink/
COPY custom_config.inc.php /var/www/html/testlink/
COPY testlink.conf /etc/httpd/conf.d/testlink.conf

RUN mkdir -p /var/log/testlink/ && \
    chmod 777 /var/log/testlink/ && \
    mkdir -p /uploads && \
    chmod 777 /uploads

COPY create_tables_postgres.sh /
RUN chmod +x /create_tables_postgres.sh

ENTRYPOINT /create_tables_postgres.sh && /run-httpd.sh 