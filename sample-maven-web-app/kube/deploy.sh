#!/bin/bash

#Firstly sleep for 1 minute to wait for the Pods to pull the image and be deployed
sleep 60

#Changing to the directory where kubectl is installed
cd ..
cd ..

#Expose the deployment to create a NodePort service
./kubectl expose deployment web-app --type=NodePort

#Get that Port and print it with the full IP of the web-app!
PORT=$(./kubectl get service web-app --output='jsonpath="{.spec.ports[0].nodePort}"')
eval echo 192.168.49.2:${PORT}/sample-web-app 

