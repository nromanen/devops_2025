# 🐶 Vagrant 

## 1. Скачуємо та встановлюємо Vagrant

- Встановлюємо **Vagrant**: https://developer.hashicorp.com/vagrant/downloads

---

## 2. Робимо робочу папку для Vagrant

```bash
mkdir vagrant_one
cd vagrant_one
```

## 3. Ініціалізуємо папку
```
vagrant init
```

### У папці з’явиться файл `Vagrantfile`

## 4. Вносимо запис у `Vagrantfile` з необхідними налаштуваннями

```
 Vagrant.configure("2") do |config|
  # Використовуй образ Ubuntu
  config.vm.box = "ubuntu/jammy64"

  # Налаштування проміжного адаптера (host-only network)
  config.vm.network "private_network", ip: "192.168.100.100"

  # Виділення ресурсів
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end

  # Скрипт для встановлення Java
  config.vm.provision "shell", inline: <<-SCRIPT
    sudo apt-get update
    sudo apt-get install -y openjdk-17-jdk
  SCRIPT

  # Увімкнення доступу через пароль
  config.ssh.insert_key = false
  config.vm.provision "shell", inline: <<-SCRIPT
    echo 'vagrant:vagrant' | sudo chpasswd
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
  SCRIPT

  # Тригер для запуску Java-додатка
  config.trigger.after :up do
    puts "Running Java application"
    config.vm.provision "shell", inline: <<-SCRIPT
      cd /vagrant && ./gradlew bootRun
    SCRIPT
  end

  # Налаштування таймауту для завантаження
  config.vm.boot_timeout = 600
end

```
## 5. Запускаємо Vagrant

```
vagrant up
```
Віртуальна машина буде створена та налаштована автоматично.

## 6 Після успішного запуску відкрий у браузері:
```
http://192.168.100.100:8080/dogs
```
### [Результат](https://drive.google.com/file/d/1ai29nyKTu5d4c5uTrT_mZvSkeoLLZQnO/view?usp=drive_link)

## [Скріншоти](https://drive.google.com/drive/folders/1k2W8e8ewBShqrLoSq7-PmWswfYWJzb3z?usp=drive_link)
