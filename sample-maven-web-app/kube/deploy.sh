#!/bin/bash

sleep 60
cd ..
cd ..
./kubectl expose deployment web-app --type=NodePort
PORT=$(kubectl get service web-app --output='jsonpath="{.spec.ports[0].nodePort}"')
eval echo 192.168.49.2:${PORT}/sample-web-app 

