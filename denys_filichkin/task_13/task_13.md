## Vagrant

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.define "web" do |web|
        web.vm.box = "generic/oracle7"
        web.vm.network "private_network", ip: "192.168.33.10"
        web.vm.provider "virtualbox" do |vb|
            vb.name = "web"
            vb.cpus = 2
            vb.memory = 4096
        end
    end

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
