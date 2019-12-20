# Dev box

- A vagrant project with an Ubuntu Bionic box with pre-installed tools.
  - Install Oracle Virtual Box (https://www.virtualbox.org/wiki/Downloads)
  - Install Vagrant (https://www.vagrantup.com/downloads.html)
  - Install Vagrant Plugin
    `vagrant plugin install vagrant-disksize`
    `vagrant plugin install vagrant-env`

Typing `vagrant` from the command line will display a list of all available commands.

## Tools included
* The following tools are included if you want to change any version edit the `.env` file
  - Git & Git LFS
  - RabbitMq 3.8.2
  - Mongo 3.6.16
  - Redis 5.x
  - Postgres 9.5
  - Nodejs 12.x
  - Python3
---


## Setting up VM

1. Install VM by running below command

```bash
  vagrant up
```

2. SSH into the VM

```bash
  vagrant ssh
```