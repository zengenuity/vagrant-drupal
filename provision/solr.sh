#!/usr/bin/env bash

# Solr
apt-get install -y unzip openjdk-7-jre
cd /tmp
wget -q http://apache.claz.org/lucene/solr/5.2.1/solr-5.2.1.tgz
tar xzf solr-5.2.1.tgz solr-5.2.1/bin/install_solr_service.sh --strip-components=2
/tmp/install_solr_service.sh /tmp/solr-5.2.1.tgz
git clone --branch master http://git.drupal.org/sandbox/cpliakas/1600962.git
mkdir -p /var/solr/data/app/conf
cp /tmp/1600962/conf/5.x/* /var/solr/data/app/conf
chown -R solr.solr /var/solr/data/app
service solr restart
