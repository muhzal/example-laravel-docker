## Basic Stack
This is a basic laravel stack environment built using Docker Compose. It consists following:
* PHP 7.0
* Apache 2.4
* Mariadb 10
* Laravel 5.5
## Installation
- Clone this repository on your local computer. Run the `docker-compose up -d`.
  ```shell
  git clone https://github.com/muhzal/example-laravel-docker.git
  cd example-laravel-docker/
  ```
- Already existing project ?
  * Remove all example files on `src/` directory
    ```shell
    rm -rf src/*
    ```
  * Move your project files to `src/`
    ```shell
    mv /path/your/existing/project/* ./src/
    ```
- Run the docker's container
  ```shell
  docker-compose up -d
  ```
Your apps is now ready!! You can access it via `http://localhost`.

## How to Use
#### Artisan command
You should connect to web server using `docker exec` command to perform artisan command. Use below command to login to container:
```shell
docker exec -it laravel-app /bin/bash
```
Perform some artisan command
```shell
root@441d69bf9bee:/var/www/html# php artisan key:generate
```
#### Database Configuration
use the following configurations value for `.env` file:
* DB_HOST=mariadb
* DB_DATABASE=laravel-db
* DB_USER=root
* DB_PASSWORD=secret
#### Apache2 Configuration
You can add or modifie virtual host configuration on `docker/vhost`
#### More configuration ?
Feel free to modified Dockerfile and docker-compose.yml file.

## Reference
* Docker compose file : https://docs.docker.com/compose/compose-file/
* Dockerfile : https://docs.docker.com/engine/reference/builder/
* Apache2 : https://httpd.apache.org/
