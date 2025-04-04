
# Task #13 - Vagrant
---



## Create a Vagrantfile that automates the creation and configuration of a VirtualBox virtual machine to run a Java application

in my case i was doing task on Mac (Apple silicon). So i made 2 files, on for mac(Apple silicon) and Linux/ windows (x86). Sience Mac does not support run virtual on the x86 architecture 


for example i used another linux image 
```
ubuntu/jammy64  >>  perk/ubuntu-2204-arm64 
```
and another virtual machine, because VirtualBox does not support vagrant on ARM

```
VirtualBox >> QEMU

```



For Mac (m1/m2/m3/m4)

``` ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_deps = <<-SHELL
  sudo apt update
  sudo apt install -y openjdk-17-jdk gradle
  cd /vagrant
  ./gradlew bootRun
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "perk/ubuntu-2204-arm64"

  config.vm.provider "qemu" do |qe|
    qe.memory = 4096
    qe.cpus = 2
    qe.arch = "aarch64"
    qe.machine = "virt"
    qe.cpu = "max"
    qe.net_device = "virtio-net"
    qe.ssh_port = "50222"  
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  
  config.vm.provision "shell", inline: $install_deps
  
#  config.trigger.after :up do |trigger|
#    trigger.info = "стартуэм апку..."
#    trigger.run = { inline: "cd /vagrant && ./gradlew bootRun" }
#  end
end

```

For PC

```ruby
$install_deps = <<-SHELL
  sudo apt update
  sudo apt install -y openjdk-17-jdk gradle
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.network "private_network", ip: "192.168.100.100"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: $install_deps

  config.trigger.after :up do |trigger|
    trigger.info = " http://192.168.100.100:8080/dogs"
    trigger.run = { inline: "cd /vagrant && ./gradlew bootRun" }
  end
end

```


in a directory you can find 2 Vagrant files Vagrantfile.arm64  and Vagrantfile.x86


on mac (Apple silicon m1/m2/m3/m4)

```bash
vagrant up --provider=qemu --vagrantfile=Vagrantfile.arm64
```

On PC (Windows/Linux)

```bash
vagrant up --provider=virtualbox --vagrantfile=Vagrantfile.x86
```


## ScreenShots


Link - (https://drive.google.com/file/d/1ADN7de5X1-bfSnyS4xzetDRdEjDujn7I/view?usp=sharing)

Link - (https://drive.google.com/file/d/1NIgsdAWjjVNkJnjKkuOzXsPckal-oqOj/view?usp=sharing)

Link - (https://drive.google.com/file/d/1bn5J_DI9reUd6x6leMF46VAd8ARrzZFK/view?usp=sharing)

Link - (https://drive.google.com/file/d/1qKRpkB3UMFtitJTkXAKkoavZDG5HjLg0/view?usp=sharing)
