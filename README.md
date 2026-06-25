*This project has been created as part of the 42 curriculum by micha.*

## Description
The **Inception** project aims to broaden knowledge of system administration by deploying a multi-container infrastructure using Docker and Docker Compose. The goal is to build a highly available and secure web application stack in a virtual machine environment without relying on pre-built, ready-to-use images.

## Project Description
This infrastructure strictly follows the separation of concerns principle, where each service (NGINX, WordPress + PHP-FPM, MariaDB) runs in its own dedicated container based on Alpine Linux.

### Technical Design Choices & Comparisons

* **Virtual Machines vs Docker:**
  A Virtual Machine (VM) virtualizes the hardware, running a full guest Operating System (OS) on top of a hypervisor. This makes VMs heavy and resource-intensive. Docker, on the other hand, virtualizes at the OS level. Containers share the host OS kernel, making them lightweight, fast to start, and highly efficient in terms of resource consumption.

* **Secrets vs Environment Variables:**
  Environment variables are a simple way to pass configuration to containers, but they can be exposed via `docker inspect` or within the container's environment. Docker Secrets provide a more secure mechanism by mounting confidential data (like passwords or API keys) as read-only files in memory (`tmpfs`), meaning they are never stored permanently on disk or exposed as plaintext environment variables.

* **Docker Network vs Host Network:**
  Using the `host` network driver allows a container to share the host's networking namespace directly, stripping away network isolation. In this project, a custom user-defined **Docker bridge network** (`inception`) is used. This ensures secure, isolated DNS resolution and communication exclusively between our specific containers, without exposing internal ports (like 3306 or 9000) to the host.

* **Docker Volumes vs Bind Mounts:**
  Bind mounts map an exact, existing file path on the host to the container. They are highly dependent on the host's file system structure. Docker Volumes are fully managed by Docker, isolated from the host machine's core file system, and provide better performance, backup capabilities, and cross-platform compatibility. This project uses volumes mapped to the `/home/micha/data` directory for persistent storage.

## Instructions
To compile and run the project:
1. Make sure your domain is set locally. Edit `/etc/hosts` and add: `127.0.0.1 micha.42.fr`
2. Run `make` or `make all` at the root of the directory to build and start the containers in the background.
3. Access the site via `https://micha.42.fr`.
4. Run `make down` to stop the containers, or `make fclean` to completely remove containers, networks, and data volumes.

## Resources
* [Official Docker Documentation](https://docs.docker.com/)
* [Alpine Linux Package Management](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management)
* **AI Usage:** Generative AI (Gemini) was utilized to structure this documentation, assist in understanding PID 1 constraints for Dockerfiles, and provide examples for bash script error handling. The generated configurations were reviewed, modified, and deeply understood before inclusion.