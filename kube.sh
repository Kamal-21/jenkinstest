#!/bin/bash
Path="/home/kamal/docker-kube.yaml"
minikube start
kubectl apply  -f "$Path"

	
