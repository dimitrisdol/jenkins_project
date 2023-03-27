#!/bin/bash

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl port-forward service/web-app-service 8081:80
