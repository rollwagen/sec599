# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "dc" do |cfg|
    cfg.vm.box = "windows_2016_vmware"
    cfg.vm.hostname = "dc"

    # use the plaintext WinRM transport and force it to use basic authentication.
    # NB this is needed because the default negotiate transport stops working
    #    after the domain controller is installed.
    #    see https://groups.google.com/forum/#!topic/vagrant-up/sZantuCM0q4
    cfg.winrm.transport = :plaintext
    cfg.winrm.basic_auth_only = true

    cfg.vm.communicator = "winrm"
    cfg.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    #cfg.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
    cfg.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    cfg.vm.network :private_network, ip: "192.168.38.2", gateway: "192.168.38.1"
    #cfg.vm.network :private_network, ip: "192.168.38.3", gateway: "192.168.38.1", dns: "192.168.38.2"

    #cfg.vm.provision "shell", path: "scripts/fix-second-network.ps1", privileged: false, args: "192.168.38.2"
    #cfg.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
    #cfg.vm.provision "reload"
    #cfg.vm.provision "shell", path: "scripts/provision.ps1", privileged: false

    cfg.vm.provider "vmware_fusion" do |v, override|
      v.memory = 1280 
      v.cpus = 2
      v.gui = true
    end

  end

end
