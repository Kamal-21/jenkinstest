#!/bin/bash
Path="/home/kamal/docker-kube.yaml"
minikube start
sleep 30
kubectl apply  -f "$Path"


	
