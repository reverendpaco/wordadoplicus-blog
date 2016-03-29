#!/usr/bin/env bash

mkdir -p ~/opt/packages/hugo && cd $_
wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz
gzip -dc hugo_0.15_linux_amd64.tar.gz | tar xf -
rm hugo_0.15_linux_amd64.tar.gz

mkdir ~/bin
ln -s ~/opt/packages/hugo/hugo_0.15_linux_amd64/hugo_0.15_linux_amd64 ~/bin/hugo

ln -s /vagrant /home/vagrant/site

cd /home/vagrant
ln -s /vagrant/.tmux.conf
ln -s /vagrant/.tmux-session
ln -s /vagrant/tmux-session.sh
tmux-session.sh restore

curl -L https://github.com/reverendpaco/vimrc/archive/master.tar.gz | tar xzv && mv vimrc-master .vim


curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -b ~/bin/aws
