# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|



  config.vm.define "elastic" do |config|
    config.vm.box = "bento/ubuntu-18.04"
    config.vm.hostname = "elastic"
    config.vm.network "private_network"
    #config.vm.network "private_network", ip: "192.168.10.20/16"
    #config.vm.network "private_network",
    #	ip: "192.168.10.18",
    #	netmask: "16"
    config.vm.provision "shell", path: "elastic.sh"

    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Elastic - Ubuntu 18.04"
      vmware.memory = 1792
      vmware.cpus = 2
      vmware.gui = false 
    end

  end



  config.vm.define "jumphost" do |config|
    config.vm.box = "windows_10_vmware"
    config.vm.hostname = "jumphost"

    config.vm.communicator = "winrm"

    config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_tcp", auto_correct: true, protocol: "tcp"
    config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_udp", auto_correct: true, protocol: "udp"

    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Jumphost - Member Client - Windows 10"
      vmware.memory = 2048
      vmware.cpus = 2
      vmware.gui = false
    end

    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Network (ethernet adapter) config; need to set via script as "configuring 
    # secondary network adapters through VMware on Windows is not yet supported.:
    config.vm.network "private_network", ip: "192.168.10.17/16"
    config.vm.provision "shell", path: "./vagrant_scripts/configure_network.ps1", args: "192.168.10.17"
    config.vm.provision "shell", path: "./vagrant_scripts/join_domain.ps1"
    config.vm.provision "shell", path: "./vagrant_scripts/install_jumphost_tools.ps1"
    config.vm.provision "shell", path: "./vagrant_scripts/populate_ad.ps1"
  end


  config.vm.define "windows01" do |config|
    config.vm.box = "windows_10_vmware"
    config.vm.hostname = "windows01"

    config.vm.communicator = "winrm"

    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_tcp", auto_correct: true, protocol: "tcp"
    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_udp", auto_correct: true, protocol: "udp"

    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Windows01 - Member Client - Windows 10"
      vmware.memory = 1536
      vmware.cpus = 2
      vmware.gui = false
    end

    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Network (ethernet adapter) config; need to set via script as "configuring 
    # secondary network adapters through VMware on Windows is not yet supported.:
    config.vm.network "private_network", ip: "192.168.10.15/16"
    config.vm.provision "shell", path: "./vagrant_scripts/configure_network.ps1", args: "192.168.10.15"
    config.vm.provision "shell", path: "./vagrant_scripts/join_domain.ps1"
  end



  config.vm.define "windows02" do |config|
    config.vm.box = "windows_10_vmware"
    config.vm.hostname = "windows02"

    config.vm.communicator = "winrm"

    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_tcp", auto_correct: true, protocol: "tcp"
    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_udp", auto_correct: true, protocol: "udp"

    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Windows02 - Member Client - Windows 10"
      vmware.memory = 1536
      vmware.cpus = 2
      vmware.gui = false
    end
 
    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Network (ethernet adapter) config; need to set via script as "configuring 
    # secondary network adapters through VMware on Windows is not yet supported.:
    config.vm.network "private_network", ip: "192.168.10.16/16"
    config.vm.provision "shell", path: "./vagrant_scripts/configure_network.ps1", args: "192.168.10.16"
    config.vm.provision "shell", path: "./vagrant_scripts/join_domain.ps1"
  end





  config.vm.define "dc" do |config|
    config.vm.box = "windows_2016_vmware"
    config.vm.hostname = "dc"

    config.vm.communicator = "winrm"

    # Network (ethernet adapter) config; need to set via script as "configuring 
    # secondary network adapters through VMware on Windows is not yet supported.:
    config.vm.network "private_network", ip: "192.168.5.5/16"
    config.vm.provision "shell", path: "./vagrant_scripts/configure_network.ps1", args: "192.168.5.5"

    config.vm.network "forwarded_port", guest: 5985, host: 5985, id: "wimrm", auto_correct: true
    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_tcp", auto_correct: true, protocol: "tcp"
    #config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp_udp", auto_correct: true, protocol: "udp"
    config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: true

    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Provisioning / configuration scripts
    config.vm.provision "shell", path: "./vagrant_scripts/install_adds.ps1"
    config.vm.provision "shell", path: "./vagrant_scripts/setup_forest.ps1"
    #-- NOT WORKING ON DC -- config.vm.provision "shell", path: "./vagrant_scripts/populate_ad.ps1"
    
    config.vm.provider "vmware_desktop" do |vmware|
    vmware.memory = 2560
    vmware.cpus = 3
    vmware.gui = false
    vmware.vmx["displayname"] = "DC - Domain Controller - Windows Server 2016"
    end
end

end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
