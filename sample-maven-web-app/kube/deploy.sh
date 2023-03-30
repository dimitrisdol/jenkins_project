#!/bin/bash

cd ..
cd ..
./kubectl port-forward service/web-app-service 8081:80
