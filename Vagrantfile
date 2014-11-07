# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # We will be using ubuntu 14.04 64-bit
  config.vm.box = "ubuntu/trusty64"

  # Run our install script
  config.vm.provision "shell", path: "etc/install/run.sh"

  # Virtualbox specific settings
  config.vm.provider "virtualbox" do |vb|
    # Allocate 2048 or 2GB of memory for virtual machine  
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    # Start VM with a GUI
    vb.gui = true
  end

end
