!#/bin/bash

#server
apt-get update --fix-missing

apt-get -y install apache2

openssl genrsa -out mydomain.key 2048

openssl req -new -key mydomain.key -out mydomain.csr -subj "/C=RU/ST=KRD/L=Russia/O=CDB_SCHL/CN=mydomain.local"

openssl x509 -req -days 365 -in mydomain.csr -signkey mydomain.key -out mydomain.crt
#-startdate 20240411000000Z

cp mydomain.crt /vagrant/mydomain.crt

# Создание PEM-файла, который содержит ключ и сертификат
#cat mydomain.key mydomain.crt > mydomain.pem

cp mydomain.crt /usr/local/share/ca-certificates/mydomain.crt

update-ca-certificates

rm -f /etc/apache2/sites-enabled/000-default.conf

cp /vagrant/mydomain.conf /etc/apache2/sites-enabled/mydomain.conf

a2enmod ssl

service apache2 restart