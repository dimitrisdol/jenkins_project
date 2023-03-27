#!/bin/bash

docker stop jenkins
docker stop jenkins-docker
docker rm jenkins
docker rm jenkins-docker
docker stop nexus
docker rm nexus
