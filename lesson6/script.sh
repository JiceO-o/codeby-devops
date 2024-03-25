#!/bin/bash

#connect to server via private key
ssh -o "StrictHostKeyChecking no" -i /vagrant/.vagrant/machines/server/vmware_desktop/private_key vagrant@172.17.177.21
#ssh -i "/vagrant/.vagrant/machines/server/vmware_desktop/private_key" server
