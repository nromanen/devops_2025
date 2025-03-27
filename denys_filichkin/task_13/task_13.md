## Vagrant

[vagrant-DenysPhV](https://github.com/DevOps1-Fundamentals/vagrant-DenysPhV/blob/main/Vagrantfile)

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Налаштування VM для Angular CLI 17
  config.vm.define "angular" do |angular|
    angular.vm.box = "bento/ubuntu-22.04"
    angular.vm.network "private_network", ip: "192.168.33.10"
    angular.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 2
    end

    angular.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update -y
      sudo apt-get upgrade -y
      sudo apt-get install -y curl gnupg2 software-properties-common
      curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
      sudo apt-get install -y nodejs
      sudo npm install -g @angular/cli@17
    SHELL
  end
# this code while don't work
    config.vm.define = "db" do |db|
        db.vm.box = "generic/oracle7"
        db.vm.network "private_network", ip: "192.168.33.11"
        db.vm.provider "virtualbox" do |vb|
            vb.name = "db"
            vb.cpus = 2
            vb.memory = 4096
        end
    end
end

```
