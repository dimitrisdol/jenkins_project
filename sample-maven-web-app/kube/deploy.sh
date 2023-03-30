#!/bin/bash

sleep 60
cd ..
cd ..
./kubectl port-forward service/web-app-service 8081:80
