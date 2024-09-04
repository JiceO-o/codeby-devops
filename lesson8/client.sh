!#/bin/bash

echo "172.17.177.21 mydomain.local" >> /etc/hosts
echo "172.17.177.21 www.mydomain.local" >> /etc/hosts


cp /vagrant/mydomain.crt /usr/local/share/ca-certificates/mydomain.crt
update-ca-certificates