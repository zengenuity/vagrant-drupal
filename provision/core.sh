#!/usr/bin/env bash

apt-get update
apt-get install -y unzip git
cp /vagrant/config/apps/core/.gitignore_global /home/vagrant
cp /vagrant/config/apps/core/.gitignore_global /root
git config --global core.excludesfile '~/.gitignore_global'
su - vagrant -c "git config --global core.excludesfile '~/.gitignore_global'"
