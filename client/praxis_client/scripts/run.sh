#/bin/bash

docker build -t flutter-web-app .
docker run -p 8080:80 flutter-web-app

