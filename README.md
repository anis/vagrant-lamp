# vagrant-web
Vagrant-web provides you a [Vagrant][3] configuration for setting up a clean web development environment on a Windows machine (although it would probably work on any other host OS).

By default, you'll get:
* a samba share: most performant way to share folders with your guest machine (and symlinks-problem-free)
* a private network
* a running [Puppet][6] provisioning, coupled with [Librarian-Puppet][5], for an easy customization

Please note this repository is essentially used to save my own development environment but feel free to use it as a start for yours.

## Requirements
* [Vagrant 1.7][1] or higher
* [Virtualbox 4.3][2] or higher

## Usage
### Basic installation
Clone this repository in the folder of your choice:

```sh
$ git clone https://github.com/anis/vagrant-web.git
```

Create a configuration file for Puppet provisioning. For a basic installation, just create a file `puppet/manifests/config.pp` copied from `puppet/manifests/config.pp.dist`.

Now you can gently wake your guest up:

```sh
$ vagrant up
```

To access to the files of your guest from your host, connect a network drive with the following settings:
* destination: `\\192.168.19.89\vagrant`
* username: `root`
* password: `samba`

To connect to your guest, establish an ssh connection:
* username: `vagrant`
* password: `vagrant`

```sh
$ ssh vagrant@192.168.19.89
$ vagrant@192.168.19.89's password: vagrant
```

That's all, you can start configuring your machine the way you want.

### Customization
If you feel like customizing your machine, a few configuration entries are already waiting for you:
* in the top of `Vagrantfile` for:
 * the network and hardware of the guest
 * the version of Puppet and Librarian-Puppet
* the whole [puppet/Puppetfile][5] if you need Puppet modules
* `puppet/manifests/config.pp` for customizing the modules already installed
* any file in `puppet/manifests` actually

## Known issues
* **Vagrant won't get my box up and Virtualbox tells me 'VT-X is not available'**

You might have Hyper-V activated, a Windows feature that prevents your machine to boot with two processors or more. You have two potential solutions:
* reduce the number of CPUs assigned to your machine to 1 (in Vagrantfile)
* deactivate Hyper-V: see [this tutorial][4]

* **Ruby raises an exception : ERROR: While executing gem ... (Encoding::UndefinedConversionError)**

Your Ruby is not using the appropriate encoding. You have two solutions (both ugly):
* type `chcp 1252` in Windows command prompt. You will have to do that each time you open a command prompt.
* locate `registry.rb` in your local ruby install and replace `LOCALE = Encoding.find(Encoding.locale_charmap)` by `LOCALE = Encoding::UTF_8`

[1]: http://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: http://www.vagrantup.com
[4]: http://www.eightforums.com/tutorials/42041-hyper-v-enable-disable-windows-8-a.html
[5]: https://github.com/rodjek/librarian-puppet
[6]: https://docs.puppetlabs.com/learning/introduction.html