# What is this ?
Vagrant-lamp provides you a vagrant configuration for setting up a clean web development environment with:
* a private network

This repository is essentially used to save of my own development environment but feel free to use it as a start for yours.

# Requirements
## Tested on
This configuration was tested on the following environment:
* Windows 8.1 (x64)
* [Vagrant 1.7.2 (x64)][1]
* [Virtualbox 4.3.20 r96997 (x86)][2]
* [Virtualbox guest additions 4.3.20][3]

## Mandatory
You will ___definitely___ need:
* Virtualbox as your virtual provider, if you want to customize your guest machine (*memory and cpus*)

# Usage
First of all, make sure you installed all of the requirements:
* [Virtualbox][2]
* [Vagrant][1] (also make sure vagrant binary folder is in your PATH)
* [The Vagrant plugin vbguest][3]

This being done, clone this repository in the folder of your choice:

```sh
$ git clone https://github.com/anis/vagrant-lamp.git
```

You may now gently wake your guest up:

```sh
$ vagrant up
```

That's all. You can establish an SSH connection to your guest machine and start working:

```sh
$ ssh vagrant@192.168.19.89
$ vagrant@192.168.19.89's password: vagrant
```

[1]: http://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: https://github.com/dotless-de/vagrant-vbguest