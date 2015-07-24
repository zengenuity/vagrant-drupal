#!/usr/bin/env bash

# Zsh and Oh My Zsh
apt-get install -y zsh
chsh -s /bin/zsh vagrant
chsh -s /bin/zsh root
curl -s -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
su - vagrant -c "curl -s -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh"
cp /vagrant/config/apps/zsh/.zshrc /home/vagrant/.zshrc
rm -f /root/.zshrc
ln -s /home/vagrant/.zshrc /root/.zshrc
