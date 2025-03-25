# HOMEWORK - TASK_13
all files at repository ---> https://github.com/DevOps1-Fundamentals/vagrant-Lenykmax?tab=readme-ov-file

all screenshots by link ---> https://drive.google.com/drive/folders/1HsVDk2uh027neUxJCBjfDi3NyGqHAQV6?usp=drive_link
# vagrant-java-app

## Project Overview
This project automates the creation and configuration of a VirtualBox virtual machine using Vagrant. The VM is set up to run a Java application with the necessary environment configured.

## Requirements
- Vagrant
- VirtualBox

## Setup Instructions
1. Clone this repository to your local machine.

2. Start the virtual machine:
   ```bash
   vagrant up
   ```
   This command will create and configure the VM, installing the necessary Java dependencies.

## Running the Application
Once the VM is up and running, the Java application can be started automatically. If it does not start automatically, you can manually start it by SSHing into the VM and running the following command:
```bash
cd /vagrant
./gradlew bootRun
```

## Verifying the Application
To verify that the application is running, open a web browser and navigate to:
```
http://192.168.100.100:8080/dogs
```
You should see the application responding with the expected output.

## Troubleshooting
- Ensure that VirtualBox and Vagrant are installed correctly.
- Check the Vagrant logs for any errors during the setup process.
- Make sure the VM has internet access to download the necessary packages.