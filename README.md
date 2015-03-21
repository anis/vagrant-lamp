# vagrant-lamp
Vagrant-lamp provides you a [Vagrant][3] configuration for setting up a clean web development environment on a Windows machine.

This environment provides you, by default:
* a private network

This repository is essentially used to save my own development environment but feel free to use it as a start for yours.

## Requirements
### Tested on
This configuration was tested on the following environment:
* Windows 8.1 (x64)
* [Vagrant 1.7.2][1]
* [Virtualbox 4.3.20 r96997][2]

### Mandatory
You ___will___ need:
* Virtualbox as your virtual provider, if you want to customize your guest machine (*memory and cpus*)

## Usage
First of all, make sure you installed all of the requirements:
* [Virtualbox][2]
* [Vagrant][1] (also make sure vagrant binary folder is in your PATH)

This being done, clone this repository in the folder of your choice:

```sh
$ git clone https://github.com/anis/vagrant-lamp.git
```

Next, customize the configuration to match up your needs:
* Vagrantfile
* puppet/Puppetfile

Finally, you may gently wake your guest up:

```sh
$ vagrant up
```

That's all. You can establish an SSH connection to your guest machine and start working:

```sh
$ ssh vagrant@192.168.19.89
$ vagrant@192.168.19.89's password: vagrant
```

## Known issues
* **Vagrant won't get my box up and Virtualbox tells me 'VT-X is not available'**

You might have Hyper-V activated, a Windows feature that prevents your machine to boot with two processors or more. You have two potential solutions:
* reduce the number of CPUs assigned to your machine to 1 (in Vagrantfile)
* deactivate Hyper-V: see [this tutorial][4]

* **Ruby raises an exception : ERROR: While executing gem ... (Encoding::UndefinedConversionError)**

Your Ruby is not using the appropriate encoding. You have two solutions (both ugly):
* type `chcp 1252` in Windows command prompt. You will have to do that each time you open a command prompt.
* locate `registry.rb` in your local ruby install and replace `#LOCALE = Encoding.find(Encoding.locale_charmap)` by `LOCALE = Encoding::UTF_8`

[1]: http://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: http://www.vagrantup.com
[4]: http://www.eightforums.com/tutorials/42041-hyper-v-enable-disable-windows-8-a.html