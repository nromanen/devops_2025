# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_deps = <<-SHELL
  # Update and install necessary packages
  sudo apt-get update -y
  sudo apt-get install openjdk-17-jdk openjdk-17-jre curl wget zip tree -y
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key

  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

  sudo apt update
  sudo apt install jenkins -y

  echo 'JAVA_OPTS="-Djava.awt.headless=true -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true"' | sudo tee -a /etc/default/jenkins
  sudo systemctl restart jenkins
  sudo systemctl status jenkins | grep status

  echo "Show init password"
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "private_network", ip: "192.168.100.100"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
#     vb.gui = true   # Enable GUI
  end

  config.vm.provision "shell", inline: $install_deps
end
