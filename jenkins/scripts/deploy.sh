#!/usr/bin/env sh

echo "Current working directory:"
pwd
echo "Contents of current directory:"
ls -la

set -x
docker run -d -p 80:80 --name my-apache-php-app -v "$(pwd)/src":/var/www/html php:7.2-apache
sleep 10

docker ps

CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-apache-php-app)
echo "Container IP: $CONTAINER_IP"

set +x

echo 'Now...'
echo "Visit http://localhost to see your PHP application in action."