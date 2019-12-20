# Dev box

- A vagrant project with an ubuntu box with the tools needed to do cnMaestro development.
  - Install Oracle Virtual Box (https://www.virtualbox.org/wiki/Downloads)
  - Install Vagrant (https://www.vagrantup.com/downloads.html)
  - Install Vagrant Plugin
    `vagrant plugin install vagrant-disksize`
    `vagrant plugin install vagrant-env`

Typing `vagrant` from the command line will display a list of all available commands.

## Setting up VM

1. Install VM by running below commands from `cnmaestro-apps/vagrant` directory

```bash
  vagrant up
```

2. SSH into the VM

```bash
  vagrant ssh
```
