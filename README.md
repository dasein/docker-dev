# docker-dev

## Summary

`docker-dev` is used to bootstrap a docker development environment on OSX.

## Bootstrap

    curl -fsSL https://raw.githubusercontent.com/dasein/docker-dev/master/bootstrap.sh | sh

    docker-dev -h

## What it does

As part of the bootstrap.sh script, the following dependencies are installed:

    - xcode
    - homebrew
    - ansible
    - docker-dev > /usr/local/docker-dev

As a final step it calls *docker-dev upgrade* to install the remaining
docker dependencies to do docker and kubernetes development locally. What
gets installed is listed below.

A user can run *docker-dev upgrade* or *docker-dev version* to upgrade or
get information about the tools installed.

## What gets installed

        - virtualbox (iff not installed already)
        - docker
        - docker-machine
        - docker-compose
        - amazon-ecs-cli
        - kubernetes-cli
        - minikube

## License

MIT
