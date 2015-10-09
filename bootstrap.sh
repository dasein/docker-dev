#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Install xcode"
    xcode-select --install
fi

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Install homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ ! -x /usr/local/bin/ansible-playbook ]]; then
    echo "Install ansible"
    brew install ansible
fi

echo 'Checking out dockulator into /usr/local/dockulator'
rm -rf /usr/local/dockulator \
   && git clone https://github.com/dasein/dockulator.git /usr/local/dockulator

echo 'Linking docker-dev to /usr/local/bin'
ln -fs /usr/local/dockulator/bin/docker-dev /usr/local/bin
hash 1>/dev/null

echo 'Running ansible to install dependencies'
ansible-playbook /usr/local/dockulator/ansible/docker.yml -i 127.0.0.1,

echo 'Done'
echo '******************************'
echo 'Run "docker-dev" to bring up your docker dev environment'
