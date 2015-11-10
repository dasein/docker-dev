# docker-dev

## Summary

`docker-dev` is used to bootstrap a docker development environment on OSX.

## Bootstrap

    curl -fsSL https://raw.githubusercontent.com/dasein/docker-dev/master/bootstrap.sh | sh

    docker-dev -h

## What it does

**docker-dev** consists of two parts...

1) A bootstrap.sh script

Responsible for installing all the dependencies required to do docker
development on OSX. It installs the following if not already installed...

    - xcode
    - homebrew
    - ansible
    - docker-dev > /usr/local/docker-dev

As a last step, it calls ansible to install and configure the remaining
dependencies. See the [Example](#example) below for the current list of what
gets installed.


2) The docker-dev script

Wrap docker-machine and take away some of the boilerplate of bringing up a
boot2docker development environment. Right now it takes care of a minimal set
of things...

- Set some sane CPU_COUNT and MEMORY_SIZE settings for your docker-machine
- Guess your VM preference based off of what you have installed. Use
  VmwareFusion iff Virtuablox is not installed.
- Allow your machine name to be resolvable through multicast DNS (e.g.
  MACHINE_NAME.local)

In the future we probably would like to add some helpful defaults for doing the
following:

- Use nfs instead of default VM filesharing (requires sudo)
- Bring up a n+1 swarm environment
- Orchestrate helpful "service" containers to satisfy some dev dependencies
  (e.g. registry, postgres)
- Default kube, mesos, etc. dev environment

## Example

    $ curl -fsSL https://raw.githubusercontent.com/dasein/docker-dev/foo/bootstrap.sh | sh
    * Cloning docker-dev into /usr/local/docker-dev
    * Linking docker-dev command to /usr/local/bin
    * Running ansible to install dependencies

    PLAY [127.0.0.1] **************************************************************

    GATHERING FACTS ***************************************************************
    ok: [127.0.0.1]

    TASK: [Tap Caskroom] **********************************************************
    ok: [127.0.0.1]

    TASK: [Install Caskroom] ******************************************************
    ok: [127.0.0.1]

    TASK: [Check for VMware Fusion] ***********************************************
    changed: [127.0.0.1]

    TASK: [Check for Virtualbox] **************************************************
    changed: [127.0.0.1]

    TASK: [Install Virtualbox] ****************************************************
    skipping: [127.0.0.1]

    TASK: [Install Docker toolchain] **********************************************
    ok: [127.0.0.1] => (item=amazon-ecs-cli)
    ok: [127.0.0.1] => (item=docker)
    ok: [127.0.0.1] => (item=docker-machine)
    ok: [127.0.0.1] => (item=docker-compose)

    PLAY RECAP ********************************************************************
    127.0.0.1                  : ok=6    changed=2    unreachable=0    failed=0

    * Done
    *********************************************************
    *       Run 'docker-dev --help' to get started          *
    *********************************************************



## License

MIT
