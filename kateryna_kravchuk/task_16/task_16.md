# Task 16: Docker

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## Tasks

### Preparation

Use the previously created virtual machine with Linux, ensure that it is powered on and accessible. Complete the following tasks related to Docker.  

*Vagrantfile* for the VM for these tasks:  

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"
  config.vm.hostname = "docker"
  config.vm.network "private_network", ip: "192.168.33.12"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision "shell", inline: <<-SHELL
      echo "Updating modules ..."
      sudo apt-get update
  SHELL
end
```

---

### Set up Docker on the Linux VM

#### Set up Docker's **apt** repository

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

#### Install the Docker packages

```bash
 sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### Verify that the installation is successful

```bash
 sudo docker run hello-world
```

> This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.  

**Output**:  

```txt
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
e6590344b1a5: Pull complete
Digest: sha256:7e1a4e2d11e2ac7a8c3f768d4166c2defeb09d2a750b010412b6ea13de1efb19
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

---

### Run a container

Select a suitable Docker image from DockerHub that can be used to run a web application.
Use the selected Docker image to create and run a container.

0. [NGINX](https://hub.docker.com/_/nginx) is well-suited for this task.  

1. To search for the *image*:  

```bash
sudo docker search --filter is-official=true nginx
```

**Output**:  

```txt
NAME      DESCRIPTION                STARS     OFFICIAL
nginx     Official build of Nginx.   20719     [OK]
```

2. To run:

```bash
sudo docker run -p 8080:80 --rm nginx
```

> The docker `run` command automatically pulls and runs the image without the need to run `docker pull`.  

To verify *container* running: `sudo docker ps`.  

```txt
vagrant@docker:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                     NAMES
4e72c77808e0   nginx     "/docker-entrypoint.…"   9 minutes ago   Up 9 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   adoring_austin
```

3. Visit [https://localhost:8080]([https://localhost:8080) to view the [default Nginx page](https://drive.google.com/file/d/1W3RQbuBOUSwiZoXHOcn3HgFgI1PpxK52/view?usp=drive_link) and verify that the container is running.  

**Output** in the terminal (with reload and getting from another browser):  

```txt
192.168.33.1 - - [05/Apr/2025:20:05:03 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
192.168.33.1 - - [05/Apr/2025:20:05:03 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://192.168.33.12:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
2025/04/05 20:05:03 [error] 28#28: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.33.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "192.168.33.12:8080", referrer: "http://192.168.33.12:8080/"
192.168.33.1 - - [05/Apr/2025:20:05:45 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
192.168.33.1 - - [05/Apr/2025:20:11:54 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0" "-"
2025/04/05 20:11:55 [error] 28#28: *5 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.33.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "192.168.33.12:8080", referrer: "http://192.168.33.12:8080/"
192.168.33.1 - - [05/Apr/2025:20:11:55 +0000] "GET /favicon.ico HTTP/1.1" 404 153 "http://192.168.33.12:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0" "-"
```

> Press `Ctrl+C` to stop the container.  

---

### Configure the container

Configure the container to serve a simple web application that displays your full name (first name and last name) when accessed through a designated port.

0. Create a *Dockerfile*: `nano Dockerfile`.  

```dockerfile
FROM nginx
RUN echo "<h1>Kateryna Kravchuk</h1>" > /usr/share/nginx/html/index.html
```

1. Run the following to build the image:  

```bash
sudo docker build -t <user>/nginx-custom .
```

> Here `<user>` is replaced with `vagrant` (default username).  

**Output**:  

```txt
[+] Building 2.1s (6/6) FINISHED                                                           docker:default
 => [internal] load build definition from Dockerfile                                                 0.1s
 => => transferring dockerfile: 121B                                                                 0.0s 
 => [internal] load metadata for docker.io/library/nginx:latest                                      0.0s
 => [internal] load .dockerignore                                                                    0.1s 
 => => transferring context: 2B                                                                      0.0s 
 => [1/2] FROM docker.io/library/nginx:latest                                                        0.4s
 => [2/2] RUN echo "<h1>Kateryna Kravchuk</h1>" > /usr/share/nginx/html/index.html                   0.8s
 => exporting to image                                                                               0.3s
 => => exporting layers                                                                              0.1s 
 => => writing image sha256:8da19fb6cf641f25dcbcce43202dd1e99265275232dfd1935918668dcd0708a2         0.0s
 => => naming to docker.io/vagrant/nginx-custom    
 ```

2. Run the following to test the image:  

```bash
sudo docker run -p 8080:80 --rm <user>/nginx-custom
```

From the terminal:  

```txt
192.168.33.1 - - [05/Apr/2025:20:20:32 +0000] "GET / HTTP/1.1" 200 27 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
```

[Screenshot](https://drive.google.com/file/d/1wssPFNFrI0aAIglyEW4Rj_-EwxpxKO8z/view?usp=drive_link)  

---

### Dockerfile

#### Task

Create a Dockerfile to dockerize the [application](https://github.com/DevOps2-Fundamentals/example-app-nodejs-backend-react-frontend) from GitHub.  
Ensure that the Dockerfile includes all necessary configurations and dependencies required to run the application in a single container.  

#### Understanding the app structure

> Download [app files](git@github.com:DevOps2-Fundamentals/example-app-nodejs-backend-react-frontend.git) before proceeding.  

0. App uses *Node.js* for the backend and *React* for the frontend.  
1. From `/src/server/app.js`: the **port** to run the app should be `3000`.  
2. Application structure (from the app's *README*):  

| Directory | Purpose |
| --- | --- |
| `client/`| React front end code |
| `server/` | Node.js back end code|
| `static/` | Compiled front end assets. Created by webpack when you run the command `npm run build` |

3. Node.js >= v12.  

#### Dockerfile for the app

> It should be placed inside the directory where the *app files* are.  

```dockerfile
FROM node:22-alpine

WORKDIR /app

COPY . .

# Install dependencies
RUN npm install && npm run build

EXPOSE 3000

CMD ["npm", "start"]
```

---

### Build and run

Build and run your containerized application, and verify that it functions as intended.

```bash
sudo docker build -t my-app .
```

**Output**:  

```bash
[+] Building 128.9s (10/10) FINISHED                                                                                                                                                                                        docker:default 
 => [internal] load build definition from Dockerfile                                                                                                                                                                                  0.1s 
 => => transferring dockerfile: 202B                                                                                                                                                                                                  0.0s 
 => [internal] load metadata for docker.io/library/node:22-alpine                                                                                                                                                                     3.4s 
 => [internal] load .dockerignore                                                                                                                                                                                                     0.1s 
 => => transferring context: 2B                                                                                                                                                                                                       0.0s 
 => [1/5] FROM docker.io/library/node:22-alpine@sha256:9bef0ef1e268f60627da9ba7d7605e8831d5b56ad07487d24d1aa386336d1944                                                                                                              20.2s 
 => => resolve docker.io/library/node:22-alpine@sha256:9bef0ef1e268f60627da9ba7d7605e8831d5b56ad07487d24d1aa386336d1944                                                                                                               0.1s 
 => => sha256:01393fe5a51489b63da0ab51aa8e0a7ff9990132917cf20cfc3d46f5e36c0e48 1.72kB / 1.72kB                                                                                                                                        0.0s 
 => => sha256:33544e83793ca080b49f5a30fb7dbe8a678765973de6ea301572a0ef53e76333 6.18kB / 6.18kB                                                                                                                                        0.0s 
 => => sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 3.64MB / 3.64MB                                                                                                                                        1.7s 
 => => sha256:9bef0ef1e268f60627da9ba7d7605e8831d5b56ad07487d24d1aa386336d1944 6.41kB / 6.41kB                                                                                                                                        0.0s 
 => => sha256:cb2bde55f71f84688f9eb7197e0f69aa7c4457499bdf39f34989ab16455c3369 50.34MB / 50.34MB                                                                                                                                      5.8s 
 => => sha256:9d0e0719fbe047cc0770ba9ed1cb150a4ee9bc8a55480eeb8a84a736c8037dbc 1.26MB / 1.26MB                                                                                                                                        1.9s 
 => => extracting sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870                                                                                                                                             1.1s 
 => => sha256:6f063dbd7a5db7835273c913fc420b1082dcda3b5972d75d7478b619da284053 446B / 446B                                                                                                                                            2.0s 
 => => extracting sha256:cb2bde55f71f84688f9eb7197e0f69aa7c4457499bdf39f34989ab16455c3369                                                                                                                                            12.6s 
 => => extracting sha256:9d0e0719fbe047cc0770ba9ed1cb150a4ee9bc8a55480eeb8a84a736c8037dbc                                                                                                                                             0.3s 
 => => extracting sha256:6f063dbd7a5db7835273c913fc420b1082dcda3b5972d75d7478b619da284053                                                                                                                                             0.0s 
 => [internal] load build context                                                                                                                                                                                                     0.4s 
 => => transferring context: 239.27kB                                                                                                                                                                                                 0.3s 
 => [2/5] WORKDIR /app                                                                                                                                                                                                                0.7s 
 => [3/5] COPY . .                                                                                                                                                                                                                    0.2s 
 => [4/5] RUN npm install                                                                                                                                                                                                            97.4s 
 => [5/5] RUN npm run build                                                                                                                                                                                                           3.9s
 => exporting to image                                                                                                                                                                                                                2.6s
 => => exporting layers                                                                                                                                                                                                               2.5s
 => => writing image sha256:b5f0ad23160bf5e4e2af7db16018c2a56cc64c8705ad5d93cc0d9330d1f52495                                                                                                                                          0.0s
 => => naming to docker.io/library/my-app 
```

```bash
sudo docker run -d -p 3000:3000 my-app
```

---

## Notes on **Docker**  

> Each command requires `sudo` unless **Docker** has been [properly configured](https://docs.docker.com/engine/install/linux-postinstall/) after installation.  

| Command | Purpose |
| --- | --- |
| `docker ps` | Lists running containers |
| `docker stop <container_name>` | Stops a running container |
| `docker exec -it <container_name> sh` | Opens an interactive shell session inside a running container |
| `docker images` | Lists available images |
| `docker rmi <image_name>` | Removes an image |
| `docker rm <container_name>` | Removes a container |

---

## Results

[Dockerfile](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_16/example-app-nodejs-backend-react-frontend/Dockerfile)  
Screenshots:  
    - the running [web application](https://drive.google.com/file/d/1wssPFNFrI0aAIglyEW4Rj_-EwxpxKO8z/view?usp=drive_link) that displays a name.  
    - the [dockerized](https://drive.google.com/file/d/1qyAKXiDD_cizfVr46LawxecoViJBQWK2/view?usp=drive_link) GitHub application.  
