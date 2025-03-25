#### Vagrantfile
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/jammy64"

  

# Changed IP to 192.168.56.100 because my VirtualBox does not allow to use 192.168.100.100 because it falls outside the allowed range of addresses
config.vm.network "private_network", ip: "192.168.56.100"

config.vm.provider "virtualbox" do |vb|
	vb.memory = "4096"
	vb.cpus = 2
end

  
  

install_deps = <<-SCRIPT
	sudo apt update && sudo apt install -y openjdk-17-jdk
SCRIPT
 
config.vm.provision "shell", inline: install_deps

#I found my Vagrant does not support triggers running
# config.trigger.after :up do |trigger|
# trigger.info = "Starting Java application..."
# trigger.run = { "inline" => "cd /vagrant && ./gradlew bootRun" }
# trigger.command = "bash -c 'cd /vagrant && ./gradlew bootRun'"
# end

	config.vm.provision "shell", inline: "cd /vagrant && ./gradlew bootRun"
end
```

#### Link to repository
https://github.com/DevOps1-Fundamentals/vagrant-vadimN 

#### Screenshot
[JSON data in browser](https://drive.google.com/file/d/1w60E-678hzkZuBbUOKfVnnJ62I4h1eqZ/view?usp=sharing)
