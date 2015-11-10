#!/bin/bash

set -e

# Set LOCAL_DEV=true to link to local checkout of docker-dev
LOCAL_DEV=${LOCAL_DEV:-}
LOCAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_BRANCH=${GIT_BRANCH:-master}

if [[ ! -x /usr/bin/gcc ]]; then
    echo "* Installing xcode"
    xcode-select --install
fi

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "* Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ ! -x /usr/local/bin/ansible-playbook ]]; then
    echo "* Installing ansible"
    brew install ansible
fi

rm -rf /usr/local/docker-dev
if [ ! -z "$LOCAL_DEV" ]; then
    echo "* Linking /usr/local/docker-dev to $LOCAL_PATH"
    ln -sf $LOCAL_PATH /usr/local/docker-dev
else
    echo "* Cloning docker-dev into /usr/local/docker-dev"
    git clone -qb $GIT_BRANCH https://github.com/dasein/docker-dev.git /usr/local/docker-dev
fi

echo "* Linking docker-dev command to /usr/local/bin"
ln -fs /usr/local/docker-dev/bin/docker-dev /usr/local/bin
hash 1>/dev/null

echo "* Running ansible to install dependencies"
ansible-playbook /usr/local/docker-dev/ansible/docker.yml -i 127.0.0.1,

echo "* Done"
echo "*********************************************************"
echo "*       Run 'docker-dev --help' to get started          *"
echo "*********************************************************"
