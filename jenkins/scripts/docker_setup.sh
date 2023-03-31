#!/bin/bash

#Path of project locally to execute the script.
ENV_PATH=~/Desktop/jenkins_project/jenkins/

#Firstly we create a docker network .
docker network create --subnet=172.19.0.0/16 jenkins

#Then we create the jenkins Docker-in-Docker container to allow Jenkins to connect.
docker run --name jenkins-docker -d --privileged --network jenkins --network-alias docker --env DOCKER_TLS_CERTDIR=/certs -v jenkins-docker-certs:/certs/client -v jenkins-data:/var/jenkins_home -p 2376:2376 -p 3000:3000 -p 5000:5000 docker:dind --storage-driver overlay2 --ip 172.19.0.2 --insecure-registry 172.19.0.4:8082  --insecure-registry 192.168.49.4:8082

#Then we build the Jenkins container based on the Dockerfile we have created.
docker build -t jenkins_blueocean:latest -f ${ENV_PATH}Dockerfile .

#Run Jenkins container
docker run --name jenkins -d --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 -p 8080:8080 -p 50000:50000 -p 8088:8088 -v jenkins-data:/var/jenkins_home -v jenkins-docker-certs:/certs/client:ro -v ${ENV_PATH}:/home --restart=on-failure --ip 172.19.0.3 --env JAVA_OPTS="-Dhudson.plugins.git.GitSCM.ALLOW_LOCAL_CHECKOUT=true" jenkins_blueocean:latest

#Create a volume to store our Nexus repository data.
docker volume create --name nexus-data

#Run the nexus docker container. Port 8082 will be used for our Nexus Docker repository.
docker run -d --network jenkins -p 8081:8081 -p 8082:8082 -p 8083:8083 --name nexus -v nexus-data:/nexus-data --ip 172.19.0.4 sonatype/nexus3

#Create a minikube cluster to deploy our application
minikube start --driver docker --delete-on-failure --insecure-registry="192.168.49.4:8082" --insecure-registry="172.19.0.4:8082" --static-ip="192.168.49.2"

#Wait for minikube and its network to be created
sleep 120

#Connect the nexus repository and the jenkins container with minikube
docker network connect --ip 192.168.49.4 minikube nexus
docker network connect --ip 192.168.49.3 minikube jenkins
docker network connect --ip 192.168.49.5 minikube jenkins-docker
