# -*- mode: ruby -*-
# vi: set ft=ruby :

# ======================================================================
# ~~ Go ahead and pimp these the way you want
# ======================================================================

# -- Vagrant
VAGRANT_VERSION = "2"

# -- Operating system
OS_BOX = "chef/debian-7.4"

# -- Hardware
MACHINE_MEMORY = 2048
MACHINE_CPUS   = 2

# -- Network
NETWORK_IP = "192.168.19.89"

# ======================================================================
# ~~ Step back, you fool, and don't change these
# ======================================================================

# -- Plugins
need_restart = false

required_plugins = %w( vagrant-vbguest )
required_plugins.each do |plugin|
    if not(Vagrant.has_plugin? plugin)
        system("vagrant plugin install #{plugin}")
        need_restart = true
    end
end

if need_restart
    exec("vagrant #{ARGV.join(" ")}")
end

# -- Guest machine
Vagrant.configure(VAGRANT_VERSION) do |config|
    # -- Box
    config.vm.box = OS_BOX

    # -- Hardware and network
    config.vm.provider "virtualbox" do |v|
        v.memory = MACHINE_MEMORY
        v.cpus   = MACHINE_CPUS
    end

    config.vm.network "private_network", ip: NETWORK_IP
end