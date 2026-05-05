# Developer Documentation

This document outlines the technical setup, building process, and administrative commands for developers working on the Inception infrastructure.

## 1. Setting Up the Environment
Before building the project, ensure the following prerequisites are met:
* **Host configuration:** Map the local IP to the required domain name. Add `127.0.0.1 micha.42.fr` to the `/etc/hosts` file.
* **Data Directories:** The infrastructure requires host directories for persistent storage. Ensure `/home/micha/data/mariadb` and `/home/micha/data/wordpress` exist (the provided `Makefile` handles this automatically).
* **Configuration:** Copy your `.env` file into the `srcs/` directory. Ensure it contains the following mandatory keys: `DOMAIN_NAME`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_ROOT_PASSWORD`, `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`, `WP_USER`, and `WP_USER_PASSWORD`.

## 2. Building and Launching
The root directory contains a `Makefile` that wraps `docker compose` commands:
* `make` or `make all`: Creates the required data directories on the host, builds the Docker images from the custom Alpine Dockerfiles, and launches the containers in detached mode (`-d`).
* The build relies on `docker-compose.yml`, which dynamically injects environment variables and mounts the persistent volumes.

## 3. Managing Containers and Volumes
Here are useful commands for debugging and administration:
* **View Logs:** To check for errors during startup, run `docker compose -f srcs/docker-compose.yml logs -f` or `docker logs [container_name]`.
* **Enter a Container:** To inspect the internal state of a running container, execute: `docker exec -it [container_name] sh`.
* **Rebuild a Specific Service:** If you modify a Dockerfile, you can rebuild it without affecting others: `docker compose -f srcs/docker-compose.yml up -d --build [service_name]`.
* **Clean Environment:** `make fclean` stops containers, removes all generated images, deletes the custom network, and securely wipes the host data directories.

## 4. Data Storage and Persistence
* **Database Data:** The MariaDB `/var/lib/mysql` directory is bound to the host at `/home/micha/data/mariadb`.
* **Website Data:** The WordPress `/var/www/html` directory is bound to the host at `/home/micha/data/wordpress`.
* Because these rely on Docker Volumes configured with bind options to specific host paths, tearing down the containers (`docker-compose down`) will **not** result in data loss. If a container crashes or is rebuilt, it simply reattaches to these host directories and resumes its state.