#  Solr
FROM lefan/centos
MAINTAINER Alexey Larin <Alexey.I.Larin@gmail.com>

ENV SOLR_VERSION 5.2.0

RUN yum install -y tar \
                   wget \
                   unzip

RUN mkdir -p /opt/apache && \
    wget -q -O - http://apache-mirror.rbc.ru/pub/apache/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz | \
    tar -xzf - -C /opt/apache && \
    mv /opt/apache/solr-$SOLR_VERSION/ /opt/apache/solr && \
    useradd --system --shell /bin/bash --home /opt/apache/solr solr && \
    chown -R solr:solr /opt/apache/solr 
USER solr
    
EXPOSE 8983

WORKDIR /opt/apache/solr

VOLUME ["/opt/apache/solr/server/solr"]

CMD ["/bin/bash", "-c", "/opt/solr/bin/solr -f"]
