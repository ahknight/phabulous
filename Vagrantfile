# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # config.vm.network "private_network", ip: "192.168.5.5"
  config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'
  
  # You really should set this up so other installs are speedy.
  config.vm.synced_folder "~/var/cache/apt", "/var/cache/apt/archives"
  
  config.vm.provider "virtualbox" do |v|
    v.name = "phabulous.local"
    v.memory = 768
  end

  config.vm.provision "shell", path: "provision.sh"
end
