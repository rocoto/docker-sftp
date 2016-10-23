# docker-sftp

This Docker image is designed to provide sftp access to files in a WordPress
site running with the official WordPress docker image.

```sh
docker run --name wp wordpress
docker run --name sftp --volumes-from wp -e SSH_KEY=`cat ~/.ssh/id_rsa.pub` rocoto/sftp
```

```Dockerfile
db:
  image: mariadb
  environment:
    MYSQL_ROOT_PASSWORD: example

data:
  image: wordpress
  command: /bin/true
  volumes:
  - /var/www/html

sftp:
  image: rocoto/sftp
  environment:
    SSH_KEY: 'ssh-rsa ...'
  ports:
  - 22
  volumes_from:
  - data

wordpress:
  image: wordpress
  links:
  - db:mysql
  ports:
  - 8080:80
  volumes_from:
  - data
```

