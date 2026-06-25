# User Documentation

This guide provides basic instructions on how to use and manage the Inception project stack.

## 1. Provided Services
This infrastructure provides a fully functional WordPress website. It is composed of three main services:
* **NGINX:** The web server that handles incoming traffic securely. It is the only entry point to the system.
* **WordPress:** The content management system (CMS) where you can publish and manage your website.
* **MariaDB:** The backend database that securely stores all WordPress data (users, posts, settings).

## 2. Starting and Stopping the Project
* **To start the project:** Open your terminal, navigate to the root directory of the project, and type `make all`. This will automatically download necessary components and start the application in the background.
* **To stop the project:** Type `make down`. This safely shuts down the services without deleting your data.

## 3. Accessing the Website
* **Public Website:** Open your web browser and navigate to `https://micha.42.fr`. (Note: Since the security certificate is self-signed, you may need to click "Advanced" and "Proceed to website" in your browser).
* **Administration Panel:** To manage the website, navigate to `https://micha.42.fr/wp-admin`. Here you can log in using the administrator credentials.

## 4. Locating and Managing Credentials
All passwords, database users, and sensitive information are stored safely inside the `.env` file located in the `srcs/` directory (or within the `secrets/` folder). 
* To change a password, you must modify these files **before** starting the project for the first time. 
* *Warning:* Never share these files or upload them to public repositories.

## 5. Checking System Status
To verify that all services are running correctly:
1. Open a terminal.
2. Run the command: `docker ps`.
3. You should see three containers (`nginx`, `wordpress`, `mariadb`) listed with a status of `Up`.