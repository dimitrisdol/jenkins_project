#!/bin/bash

ENV_PATH=~/Desktop/jenkins_project/jenkins/

docker network create --subnet=172.19.0.0/16 jenkins

docker run --name jenkins-docker -d --privileged --network jenkins --network-alias docker --env DOCKER_TLS_CERTDIR=/certs -v jenkins-docker-certs:/certs/client -v jenkins-data:/var/jenkins_home -p 2376:2376 -p 3000:3000 -p 5000:5000 docker:dind --storage-driver overlay2 --ip 172.19.0.2 --insecure-registry 172.19.0.4:8082 

docker build -t jenkins_blueocean:latest -f ${ENV_PATH}Dockerfile .

docker run --name jenkins -d --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v jenkins-docker-certs:/certs/client:ro -v ${ENV_PATH}:/home --restart=on-failure --ip 172.19.0.3 --env JAVA_OPTS="-Dhudson.plugins.git.GitSCM.ALLOW_LOCAL_CHECKOUT=true" jenkins_blueocean:latest

docker volume create --name nexus-data

docker run -d --network jenkins -p 8081:8081 -p 8082:8082 -p 8083:8083 --name nexus -v nexus-data:/nexus-data --ip 172.19.0.4 sonatype/nexus3
